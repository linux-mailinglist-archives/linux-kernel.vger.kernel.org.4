Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE80712C18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbjEZR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjEZR7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:59:03 -0400
Received: from p3plwbeout18-05.prod.phx3.secureserver.net (p3plsmtp18-05-2.prod.phx3.secureserver.net [173.201.193.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244CC9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:59:02 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id 2biOq4rRItp5M2biPqxdQ3; Fri, 26 May 2023 10:59:01 -0700
X-CMAE-Analysis: v=2.4 cv=cKYlDnSN c=1 sm=1 tr=0 ts=6470f365
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=3-RhneuVAAAA:8
 a=FXvPX3liAAAA:8 a=oceKJ4aG_Jk7OyBK0BMA:9 a=QEXdDO2ut3YA:10
 a=VLVLkjT_5ZicWzSuYqSo:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  2biOq4rRItp5M
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.87])
        by smtp11.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1q2biO-00049q-Mk; Fri, 26 May 2023 18:59:01 +0100
Message-ID: <7a5088a8-b5dc-472d-4f43-29d68e3cde16@squashfs.org.uk>
Date:   Fri, 26 May 2023 18:59:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mm-nonmm-unstable v2 1/2] squashfs: fix page update race
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
 <20230526-squashfs-cache-fixup-v2-1-6fb7723c3647@axis.com>
Content-Language: en-GB
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20230526-squashfs-cache-fixup-v2-1-6fb7723c3647@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfAMLOAqD63ofpVwlW9P4MbZMqbkYrM3GnbTu2EJ0Qk85JEsisnhWAZaafEqmDoNODMt1kFraVCJSUbOJgnOKVydmvjB3Fd1RDBm1nQsa1kLXL8Q/gr0e
 jmNXfjGLBwjrXXSNp1XKd0JQswZJs5+LW2PZDrtqK7nOZBZhR7JsJk04G341xtsCwNREOvrxZq9ABQOixM/I+Uz5u7pbBEYk72U=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/2023 14:57, Vincent Whitchurch wrote:
> We only put the page into the cache after we've read it, so the
> PageUptodate() check should not be necessary.  In fact, it's actively
> harmful since the check could fail (since we used find_get_page() and
> not find_lock_page()) and we could end up submitting a page for I/O
> after it has been read and while it's actively being used, which could
> lead to corruption depending on what the block driver does with it.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>


Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

