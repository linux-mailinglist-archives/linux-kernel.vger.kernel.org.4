Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F16662CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbjAKS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:28:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA932E8A;
        Wed, 11 Jan 2023 10:28:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673461716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbHz+r4gS67P31F5u+ZSysVNdDYKMiNjdT2EucbKd3E=;
        b=lXvvoQHKqOwihWoCJuyJb72HKyLp5RP/InGDCYN8zYLAmIvUi6cu1Inbm6IMGqnsum/sng
        MhLJhGsbPX62sryYcJ3vS+Pzfl5DkG2gyl06GVpuwE3ODaPSMmpVJ+ztuFZ0j1w89XuZpI
        LsanNEv/7SgUUTcidB51fTnqX28nyOXlHRKNBJqjbHJxciEr9ZnRK1q1vkc66bER3fl0R0
        Iw0j/ZI0cUggH6MH6snMiievoZ+/BfWSKtOZV1KDYIdEerva/DkVILSrId6iqm20+qOZmi
        2vvq+My7nwEc1dLjT8uSSjvTD9BQxzPK8ZEie0xM6KXOYo0Ae0nL/7Bfpf95xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673461716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbHz+r4gS67P31F5u+ZSysVNdDYKMiNjdT2EucbKd3E=;
        b=0zLjVYnmGPMoqdCm1kV1PGYNKkXR61UrEyJJqOJ/3o4IwHpYaJJxSavLzAipZyd3eayY7b
        D4Kdqlno/G3WH4Bw==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/19] irqdomain: Switch to per-domain locking
In-Reply-To: <878rjcbnp8.ffs@tglx>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-20-johan+linaro@kernel.org> <87mt7sbtf9.ffs@tglx>
 <Y5c6z3t+sV/kIMjF@hovoldconsulting.com> <878rjcbnp8.ffs@tglx>
Date:   Wed, 11 Jan 2023 19:28:35 +0100
Message-ID: <871qo1hqng.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12 2022 at 17:18, Thomas Gleixner wrote:
> On Mon, Dec 12 2022 at 15:29, Johan Hovold wrote:
>> I added to irq_domain_set_mapping() and which is is called for each
>> (inner) domain in a hierarchy when allocating an IRQ.
>
> Hmm. Indeed that should do the trick.
>
> Some comments would be appreciated as the rules around domain->root are
> far from obvious.

Any update on this one?
