Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC26E991C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjDTQFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjDTQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:05:31 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4626422A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:05:29 -0700 (PDT)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4Q2MvD2jWzz4Fxv;
        Thu, 20 Apr 2023 12:05:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1682006728; bh=EKV0LEfOfid5iH2xb19C4EKN8EQAQyvXH2/h/3MLTF4=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=i+IL9/4WQSGafLFxLiTR2M+bo95QoJhM4Og4otnXuaWjJWZfbU++6l6QUh75Gdq4B
         XD7IS0GIbVOPwSUfitDzrX5u7kofffpXjEyXgLqQJeNHI6TbajyER09A8DHCH5lg56
         KtvmHfvkUvtEPvk2DdAxXFxhyB+CFAunSTJxCC5I=
X-Panix-Received: from 166.84.1.2
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Thu, 20 Apr 2023 12:05:28 -0400
Message-ID: <29c370c79a9775398bcd0f111196f677.squirrel@mail.panix.com>
In-Reply-To: <20230420155705.21463-1-pa@panix.com>
References: <20230420155705.21463-1-pa@panix.com>
Date:   Thu, 20 Apr 2023 12:05:28 -0400
Subject: Re: [PATCH v3] firmware/sysfb: Fix VESA format selection
From:   "Pierre Asselin" <pa@panix.com>
To:     "Pierre Asselin" <pa@panix.com>
Cc:     dri-devel@lists.freedesktop.org, "Pierre Asselin" <pa@panix.com>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I went back to nested max3() after all as Thomas asked.  My first cut
had casts in the innermost max3() and the code looked truly awful.  I
decided that two casts are tolerable.  I added a comment to explain
the casts.

Against clamp_t(u8,lfb_depth,1,32): the clamp_t() macro does no
typechecking;  might as well just cast lfb_depth to u8, but that assumes
the value would fit (positively crazy if it doesn't, but still.)
Instead, I widen the other two args of the outer max3().

--PA

