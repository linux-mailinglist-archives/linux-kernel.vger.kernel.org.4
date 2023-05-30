Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA267715F11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjE3MXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE3MW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:22:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524CF3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:22:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685449348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jRbNquC92eIg+iZLP2C7Zs044JQXYMxXw9YcsxZzd8=;
        b=M1TWmt4FMVc7RuToeXRQx53Zybb+l+HiWAxepdoKrOpph8CMkDy41b/jUSxAT9TOJSBf0Y
        KaW009XO8rKLfCgrzSW27xb+yJYn+OK21TTaCxaZrNSjrYZ5/yDE3qLP5oGp7DToLVbdCa
        P7WZrxdEOD4HxrLW3oJ1k5czheai0paQWAq97wegJjXbJbRAbXCLdqC/u9+Mapd5G4K+k8
        J6Kid+26lI+G2NShyQpLV85mYX+bMk+bdU1S17XscmE2wJUWWJoJJ1yZBHWee3kpg3UghP
        pZkyla0pdtQ2lLyHSHWwiIWHEVVLBbwxo9dZHZNhTi72trF1OPMIPofE/6Jw2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685449348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jRbNquC92eIg+iZLP2C7Zs044JQXYMxXw9YcsxZzd8=;
        b=Dk9sTfY4fdMLb1d+9pxmukaH3f3wadP1H7JA4ktOaML5HhLtBu3IDJjLCVSTK/zAkHB8cz
        BM5akaATTxsRLBBg==
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <CAAhV-H6uZWgZQsVh=1-U2B4ZZZz6EPJ3gkv0mxHSNGOMPB=VwQ@mail.gmail.com>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <86fs7gdhid.wl-maz@kernel.org>
 <CAAhV-H6KpNhL5VvumvhcAKGOpe-EO0zfzm_xPprP0rTVf18Leg@mail.gmail.com>
 <87ilcblc72.ffs@tglx>
 <CAAhV-H41vDyBktE25Fdb34QtZ_yWSgTq4yMOyfD9H7YytKS3RA@mail.gmail.com>
 <878rd6lwlh.ffs@tglx>
 <CAAhV-H6uZWgZQsVh=1-U2B4ZZZz6EPJ3gkv0mxHSNGOMPB=VwQ@mail.gmail.com>
Date:   Tue, 30 May 2023 14:22:27 +0200
Message-ID: <877csqj9fg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at 16:34, Huacai Chen wrote:
> On Tue, May 30, 2023 at 4:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Now take that number and divide it by the number of devices on the bus
>> and you get at least a sensible limit which does not immediately cause
>> vector exhaustion.
>>
>> That limit might be suboptimal if there are lots of other devices on
>> that bus which just require one or two vectors, but that's something
>> which can be optimized via a generic command line option or even a sysfs
>> mechanism.
> Hmm, if we still use the command line, then we still have some similar
> drawbacks.

Only for optimization. Without the optimization the limit might end up
being overbroad, but it definitely prevents vector exhaustion. For quite
some cases this might be even the proper limit which does not need any
further tweaking.

Thanks,

        tglx
