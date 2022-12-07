Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6933D645F43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:51:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2A2AE21
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:51:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670431912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0A0YeZ9dVItz25cojsCaPv8/wEaHQjJNkk2aUQcFKT0=;
        b=2SkQOx/YBP7jkxttkJanXk6gdURkY4dBD1PU+2yE//TXTq45bzsxyIA988IgNC960JI/DH
        Xz7Jb7gbaB8F7gLc3YWGlElzcZBrPfh1Snpk2kYCFaXYe6xv4eXsadFa95q4SCsfKL83+X
        s/0xpdqctpUMYSfFD+E4coSupU/fYe3a6ImA4GWdpDH/WADc7XkZnWDs5kYXFVNRRikplT
        a3UW4Iz0gx0CIesUKZ8+HtTMs85+MVMxZXnHhGCiyobILeFPLFWqvXtfpzRGmmdnUuQL/3
        Rfg+96zFjhftABFkAp8Bo9qrc0OKNgrvErMAt8dQkNXBDhaBZUdxxFnq7tSWww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670431912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0A0YeZ9dVItz25cojsCaPv8/wEaHQjJNkk2aUQcFKT0=;
        b=VYIX5KQ1h0GkPiE9Os8P3/mycfCgENDTS2GpZrRi0Sb0v4+WERzCV7SHnPqb9AJhTd970Z
        Xa4ZWBWQtmaNAVAg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Curtin <ecurtin@redhat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jean Delvare <jdelvare@suse.de>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liu Peibao <liupeibao@loongson.cn>,
        Michael Walle <michael@walle.cc>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Talel Shenhar <talel@amazon.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip updates for 6.2
In-Reply-To: <20221207153758.570431-1-maz@kernel.org>
References: <20221207153758.570431-1-maz@kernel.org>
Date:   Wed, 07 Dec 2022 17:51:51 +0100
Message-ID: <87pmcvdumw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07 2022 at 15:37, Marc Zyngier wrote:
> Here's a tiny set of updates for 6.2. It's all pretty uninteresting,
> and mostly focussed on the never ending of stream of Loongarch related
> patches. Because ACPI wasn't bad enough, they also have DT now.
>
> Please pull=C2=B8

Done. Thanks!

      tglx
