Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6666DC8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDJPyU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:54:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CBB83
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:54:17 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.221.45])
        by gateway (Coremail) with SMTP id _____8DxUOUoMTRkDCkZAA--.38876S3;
        Mon, 10 Apr 2023 23:54:16 +0800 (CST)
Received: from mail-wr1-f45.google.com (unknown [209.85.221.45])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx670kMTRkU7wcAA--.29748S3;
        Mon, 10 Apr 2023 23:54:16 +0800 (CST)
Received: by mail-wr1-f45.google.com with SMTP id v6so4840139wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:54:15 -0700 (PDT)
X-Gm-Message-State: AAQBX9fpqE6Af8FziDbYFhpbBoGJqRUvaOCK+F4IVB5m6IvKRSN2apzj
        b3KDwPX6Tv8hnIiYHwKwUKAzbU0NqOtG329xya2VXw==
X-Google-Smtp-Source: AKy350ZAuQTgY0PQc2XWYXAUmPOujcjixIrHnF9HRJ9jXsgcZ+54prxApgwGkqm1CXbvxaqr9+20hrzUfJPrWRTcgEY=
X-Received: by 2002:a5d:6a8c:0:b0:2e5:e0e8:9c8d with SMTP id
 s12-20020a5d6a8c000000b002e5e0e89c8dmr1839172wru.13.1681142051984; Mon, 10
 Apr 2023 08:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230410115734.93365-1-wangrui@loongson.cn> <c90c442fe029bfb9c4487284366800b8781954e1.camel@xry111.site>
 <CAHirt9jXQcvSQPEFgW6B-qeakcRXGFfd1eYCw2g23Fmu4bbS8g@mail.gmail.com> <f568fd917bb8789fcef4206e256ef045176605e2.camel@xry111.site>
In-Reply-To: <f568fd917bb8789fcef4206e256ef045176605e2.camel@xry111.site>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Mon, 10 Apr 2023 23:53:59 +0800
X-Gmail-Original-Message-ID: <CAHirt9gnFGF1kbGFYxcNHjxpysXRLLWjX6mrcOKaN=g7E-uBQw@mail.gmail.com>
Message-ID: <CAHirt9gnFGF1kbGFYxcNHjxpysXRLLWjX6mrcOKaN=g7E-uBQw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Improve memory ops
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8Bx670kMTRkU7wcAA--.29748S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
        y3UUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:38 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> The point is "if you can reduce one instruction and one register usage
> with no harm, why not do it?" :)
>
> AFAIK bstrins.d should be available on all 64-bit LoongArch CPUs.

Hmm, I will make the change in the next version. :)

Rui

