Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1426D352B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDBBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 21:32:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718C210D;
        Sat,  1 Apr 2023 18:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=P1zn3BTPH5+hER81xqxLdjLEouLYyQrC9ukU+Ae924A=; b=hQA5JxqwFGb7Mmzv+BbhfAnXz8
        lXp3MsEXv54RjcJcPt+Vc4uCWDHallEF7Jss7jtigfJLgUNqKg+kDnhObCUGHvxfTa8VyZjdP7s6f
        M190U17D5vyEAOAjMYn2DM5SkYetIh2BqpYeCyAqLJgwrc99JvhfHroJcJzQAxv0PVnwzJ3UNkKfv
        EDL4s7nMOA/yuEqzYmCZMsoSs0RMypbrLh+RSU2EKHEY59LQtsFKtPd24yfT7DnZbseNWcw4a3XtK
        QzeyNn1/tPXEhzGcVQIaqq6eTc5zO2Mr1mURYRvU+cVX7yUeHspNZmYzXKuciWV4a1wYNmyfAfsco
        E235N+kg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pimaJ-00BYUV-1Z;
        Sun, 02 Apr 2023 01:32:43 +0000
Message-ID: <d5048f3d-fe17-72f8-0d61-a5ec5a1a9f43@infradead.org>
Date:   Sat, 1 Apr 2023 18:32:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fs/9p: Rework cache modes and add new options to
 Documentation
Content-Language: en-US
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev
Cc:     v9fs-developer@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230401-ericvh-dev-rework-cache-options-v1-1-12d3adbdd33a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/1/23 16:16, Eric Van Hensbergen wrote:
> diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
> index 0e800b8f73cc..d79bf4e41a71 100644
> --- a/Documentation/filesystems/9p.rst
> +++ b/Documentation/filesystems/9p.rst
> @@ -78,19 +78,39 @@ Options
>    		offering several exported file systems.
>  
>    cache=mode	specifies a caching policy.  By default, no caches are used.
> -
> -                        none
> -				default no cache policy, metadata and data
> -                                alike are synchronous.
> -			loose
> -				no attempts are made at consistency,
> -                                intended for exclusive, read-only mounts
> -                        fscache
> -				use FS-Cache for a persistent, read-only
> -				cache backend.
> -                        mmap
> -				minimal cache that is only used for read-write
> -                                mmap.  Northing else is cached, like cache=none
> +		The mode can be specified as a bitmask or by using one of the
> +		prexisting common 'shortcuts'.
> +		The bitmask is described below: (unspecified bits are reserved)
> +
> +			==========	================================================
> +			0b00000000	all caches disabled, mmap disabled
> +			0b00000001	file caches enabled
> +			0b00000010	meta-data caches enabled
> +			0b00000100	writeback behavior (as opposed to writethrough)
> +			0b00001000	loose caches (no explicit consistency with server)
> +			0b10000000	fscache enabled for persistent caching
> +			=========	================================================
> +

Extend the === lines to that no text extends beyond the last '=' character,
both above and below.
Otherwise there will be warnings.

> +		The current shortcuts and their associated bitmask are:
> +
> +			=========	=============================================
> +			none		0b00000000 (no caching)
> +			readahead	0b00000001 (only read-ahead file caching)
> +			mmap		0b00000101 (read-ahead + writeback file cache)
> +			loose		0b00001111 (non-coherent file and meta-data caches)
> +			fscache		0b10001111 (persistent loose cache)
> +			=========	=============================================
> +
> +		NOTE: only these shortcuts are tested modes of operation at the
> +		moment, so using other combinations of bit-patterns is not
> +		known to work.  Work on better cache support is in progress.
> +
> +		IMPORTANT: loose caches (and by extension at the moment fscache)
> +		do not necessarily validate cached values on the server.  In other
> +		words changes on the server are not guaranteed to be reflected
> +		on the client system.  Only use this mode of operation if you
> +		have an exclusive mount and the server will modify the filesystem
> +		underneath you.
>  
>    debug=n	specifies debug level.  The debug level is a bitmask.
>  
> @@ -137,6 +157,10 @@ Options
>    		This can be used to share devices/named pipes/sockets between
>  		hosts.  This functionality will be expanded in later versions.
>  
> +  directio	bypass page cache on all read/write operations
> +
> +  ignoreqv	ignore qid.version==0 as a marker to ignore cache
> +
>    noxattr	do not offer xattr functions on this mount.
>  
>    access	there are four access modes.

-- 
~Randy
