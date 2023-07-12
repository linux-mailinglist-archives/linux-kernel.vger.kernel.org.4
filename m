Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45E74FD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGLChI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGLChG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:37:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D5ED;
        Tue, 11 Jul 2023 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1ikivZ36R/uE4X28CUyULfRVxQJ2/mOsUaWRxJg8zPg=; b=BujmYURi3OAbwaG7VDTW1FPXFZ
        Wcfmx8Wmt7XP+Dtt4zu95ZMEskptXJflbFKX+REjkGnlw0Bpa3ON8Zv2yOQMfTL8L+M9TG7cYcqj1
        X1AMmyk67xkOGZfAkpA9ZN276NgiKrvIBZZoP882HdJGN/RioK7B6Hc4/ILWkTMqjgWAPxWsfcPOC
        TZYzwQLsTAAJM1f92PN7qwKyjf2JMPSde+oy7i0dwx+6rexI+lhHV0IgqeVsQm4Shf1MI9poutBT7
        mNAUpVx2EG4G19r3/akm3UySDKbU5vwq9FuYLjY8iBVb5PwEc72eocIXm8JLFsvxOqOOAXfRB9nSX
        SyzRYWTg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJPiz-00GH5s-2o;
        Wed, 12 Jul 2023 02:37:05 +0000
Message-ID: <b5ebc891-ee63-1638-0377-7b512d34b823@infradead.org>
Date:   Tue, 11 Jul 2023 19:37:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: scripts/kernel-doc does not handle duplicate struct & function names
 (e.g., in amdgpu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[just documenting this for posterity or in case someone wants to fix it.]

In drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c, one can find both

struct amdgpu_vm_tlb_seq_cb {...};

and
static void amdgpu_vm_tlb_seq_cb(...)

Of course C has no problem with this, but kernel-doc reports:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:833: WARNING: Duplicate C declaration, also defined at gpu/amdgpu/driver-core:115.

And of course, if the name of one of them is changed, kernel-doc is all happy...
not that I am suggesting that one of them should be changed.

I just want to make people aware of this. (or maybe people are already aware of this?)

-- 
~Randy
