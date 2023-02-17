Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DEA69B33E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBQTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBQTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:38:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EF85B76E;
        Fri, 17 Feb 2023 11:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IVvNxzJ/MYYOfgoLuHJ17dzipL9pSi1JZZiiDTevKw0=; b=j6Mg8xarwRuLOAkt6xKfjfU+GK
        VuWVsDRwqRFW+Xenyylnnk6wTFhc1zFSnWzxWAoHU49KB4fRExFfdmsPS5RsBfviEcuPFC921uy9L
        9Hr5l4tCsdd9Mq+L8RZF7yj/X/ZUoguJMzXh4E+DW5BZfGyC9TiwaeCw3IYOezS5GnfcDGRR7PbnR
        w6QDZ0rv8txqYW+za0a08qmt10QZ9Bqd/tQnWEBxHjktV8S5RQJbzI15mCnADRRpLgymrltXhFjdu
        7F4orbZyHkHAaatKo/SxKXMbWgMIeW84rfHeKuXL/DWQ8GPnYaXuMHnsnvHDCYR6pU7RasGrsMjWz
        mNCsdhfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT6YZ-009Znz-3q; Fri, 17 Feb 2023 19:38:07 +0000
Date:   Fri, 17 Feb 2023 19:38:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        jason@jlekstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-next v2 04/16] maple_tree: add flag MT_FLAGS_LOCK_NONE
Message-ID: <Y+/Xn11dfdn7SfBD@casper.infradead.org>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217134422.14116-5-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:44:10PM +0100, Danilo Krummrich wrote:
> Generic components making use of the maple tree (such as the
> DRM GPUVA Manager) delegate the responsibility of ensuring mutual
> exclusion to their users.
> 
> While such components could inherit the concept of an external lock,
> some users might just serialize the access to the component and hence to
> the internal maple tree.
> 
> In order to allow such use cases, add a new flag MT_FLAGS_LOCK_NONE to
> indicate not to do any internal lockdep checks.

I'm really against this change.

First, we really should check that users have their locking right.
It's bitten us so many times when they get it wrong.

Second, having a lock allows us to defragment the slab cache.  The
patches to do that haven't gone anywhere recently, but if we drop the
requirement now, we'll never be able to compact ranges of memory that
have slabs allocated to them.

