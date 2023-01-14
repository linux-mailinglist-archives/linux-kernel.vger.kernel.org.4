Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AC66ABEE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjANOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjANOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:41:01 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E25242
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673707251; bh=KawwwvIcAopLS+CUzfaq6FN0lch5RTPmyrMhaJt02v0=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DWoGChTmpx8Hi/MvtApluGi9U0dqxY3ffHnPILbm+q1GnR7v92R9rHCICpnryyDkH
         jFtRNYbEHSmjwqLSxSqBMYRbCbcxydOdpyrDx5uI9lXmLZgk11INjHQWVkZ7zbSkUY
         MN+pMEspXGbyIB6tifuURqG0eYgOvaBMyQ8oy+Xc=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 15:40:51 +0100 (CET)
X-EA-Auth: cIwL7Ka0hJ+AGbeVlaowRBnhJqla2UVvoZQAoVUfAHAR2tdceZTOQcTouU8Ku1/wcCtCCVf10W/RRSSg8uSEN/NIgoADa2h8
Date:   Sat, 14 Jan 2023 20:10:43 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: nvkm_devinit_func.disable() to be made void
Message-ID: <Y8K+61ZOag5fXu8M@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
It appears that the callback function disable() of struct nvkm_devinit_func does
not need return U64 and can be transformed to be a void. This will impact a few
drivers that have currently implementation of this callback since those always
return 0ULL. So,

Change from
	  8 struct nvkm_devinit_func {
		... ...
	15          u64  (*disable)(struct nvkm_devinit *);
	  1 };

Change to
	  8 struct nvkm_devinit_func {
		... ...
	15          void  (*disable)(struct nvkm_devinit *);
	  1 };


I am unsure if this change will have any UAPI impact. Hence wanted to confirm
with you if you think this transformation is useful. If yes, I will be happy to
submit a patch for your consideration.

Please let me know.

Thank you,
./drv


