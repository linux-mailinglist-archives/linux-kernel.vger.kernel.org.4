Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719716A1563
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBXDaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBXDa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:30:28 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3AD4FAB0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:30:22 -0800 (PST)
X-QQ-mid: bizesmtp75t1677209379t52359rj
Received: from [10.4.23.76] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 24 Feb 2023 11:29:38 +0800 (CST)
X-QQ-SSF: 01400000000000I0Z000000A0000000
X-QQ-FEAT: HPkwb3INVpDW35QzUyXHm5GCtuksjtfPvVGoC8YsFJk3IM6h0WzQQeHhFRwP0
        JFZDYZce03hVWkDKYqwCgXo7iksu3ZBfSgEfD1jwR5autpuiNHtuitvTrm4humQTt9rBh+f
        GX6FMBgdImF8m375SY58G9/+0c2TB80ibtmr2CyJhGiRbqOVB8uJfW6NXN9C/evW224OcNe
        ueXeDdRafWeJZOMZr2qhz8XJGrfd60YXoltEfq2fzeaxRmuXG5htAQq1EM8ha9kXQCZNEo7
        QRIRE+Dy3tjxebCgz+Xw88qfAsqoUSviz8tLjls37H0z4hVDnOixvtJKLl4811AIccUdcy6
        NellOjajW2Fay2rUwmQzl37/CyAVZa0Oczed2Mmsu2H81X8c8AEWGTQ4pVlLUJb0LSvzOrz
X-QQ-GoodBg: 1
Message-ID: <D9D1D797C8BE2644+74545cb0-21ea-1b04-bee1-1ed1bbe3efff@uniontech.com>
Date:   Fri, 24 Feb 2023 11:29:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] drm/vmwgfx: Work around VMW_ALLOC_DMABUF
To:     Zack Rusin <zackr@vmware.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230223070405.20228-1-tangmeng@uniontech.com>
 <c5ba07a5ad3c6b101126a97eb094c51013ee83c0.camel@vmware.com>
 <113C6E516C95FA38+f2633fe9-fb5a-616e-0e35-7559750544c9@uniontech.com>
 <2bc1750b4c3ebebf84c106b903178e5236dc396e.camel@vmware.com>
From:   Meng Tang <tangmeng@uniontech.com>
In-Reply-To: <2bc1750b4c3ebebf84c106b903178e5236dc396e.camel@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/24 11:13, Zack Rusin wrote:
> 
> That's correct. That's the way this works. The ioctl is allocating a buffer, there's
> no infinite space for buffers on a system and, given that your app just allocates
> and never frees buffers, at some point the space will run out and the ioctl will
> return a failure.
> 
Do you mean that users without certain privileges can access allocate a 
buffer because it is designed like this? so we don't need to block 
users without certain privileges to VMW_ALLOC_DMABUF success?
> As to the stack trace, I'm not sure what kernel you were testing it on so I don't
> have access to the full log but I can't reproduce it and there was a change fixing
> exactly this (i.e. buffer failed allocation but we were still accessing it) that was
> fixed in in 6.2 in commit 1a6897921f52 ("drm/vmwgfx: Stop accessing buffer objects
> which failed init") the change was backported as well, so you should be able to
> verify on any kernel with it.
> 
> z
> 
Thank you, the kernel version of my environment is lower than 6.2, I 
will verify on my kernel with commit 1a6897921f52 ("drm/vmwgfx: Stop 
accessing buffer objects which failed init").

