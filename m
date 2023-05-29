Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D27145B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjE2Hov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjE2Hot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:44:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEB1A7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:44:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685346280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5paxpN3xYOAEQ+EuARrTGAj++AZNd41FPhgcLsr3N10=;
        b=jCoWNfmxhOaBpWVY4SbBaEvb26HsRjcfXtDdEy6YYypOznC5aekQoxlho8hszhNUE+D6Uk
        p7IwnBSxmWTM7AK3vxUXC/pvPbP3dynUOpTp5+mhf2POgMZOVs9+KHr3ozYvVzX5t9ORHz
        DE4/covFNBnOXITEgpNsQ4Oz/G+941sM29bPBqEhBIgV8BaH3zVGAxhsD1OvT3Y1GRoefw
        C0G9PxzHyS6UJw1KFWArvku6W30Mn7KZJEahecyUapxVNdKgLf+izGLMotHF3a7u2zZsRZ
        yyfoBsqwjiPwUsTzJmD3711L9/xWDA0Cfji0+8vC00puHArMuIYnKDCQla80/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685346280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5paxpN3xYOAEQ+EuARrTGAj++AZNd41FPhgcLsr3N10=;
        b=R6padX2qZC11tsfG6GMKaM/LZ95ka/fsf8MtryA0H94XwnDjxFP8SuQsz7F+Hlpi6yWDWy
        tDmNdRKyB5WTjFAg==
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <CAAhV-H5ack9r4WwuC3gixx0tbwW=4h84X5yrod-1DZouWr67BA@mail.gmail.com>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
 <20230527054633.704916-2-chenhuacai@loongson.cn> <87pm6llvm6.ffs@tglx>
 <CAAhV-H5ack9r4WwuC3gixx0tbwW=4h84X5yrod-1DZouWr67BA@mail.gmail.com>
Date:   Mon, 29 May 2023 09:44:39 +0200
Message-ID: <87leh7lgyg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28 2023 at 11:42, Huacai Chen wrote:
> On Sat, May 27, 2023 at 10:03=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> On Sat, May 27 2023 at 13:46, Huacai Chen wrote:
>> > After:
>> > =3D 0: Success;
>> >> 0: The modified nvec;
>> > < 0: Error code.
>>
>> This explains what the patch does, but provides zero justification for
>> this nor any analysis why this is correct for the existing use cases.
> I checked all msi_prepare() callbacks and none of them return positive
> values now, so I think it is correct.

Still you failed to tell so in the changelog. It's not helpful if you
think it is correct. The point is that you have to make clear why it
_IS_ correct.

Thanks,

        tglx
