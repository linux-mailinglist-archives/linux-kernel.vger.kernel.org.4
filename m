Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A6DC7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDJOUK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDJOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:20:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 046102689
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:20:04 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.128.41])
        by gateway (Coremail) with SMTP id _____8Axkk4SGzRktCEZAA--.38625S3;
        Mon, 10 Apr 2023 22:20:03 +0800 (CST)
Received: from mail-wm1-f41.google.com (unknown [209.85.128.41])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxIL8OGzRkvaYcAA--.64977S3;
        Mon, 10 Apr 2023 22:20:02 +0800 (CST)
Received: by mail-wm1-f41.google.com with SMTP id gw13so2874357wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:20:01 -0700 (PDT)
X-Gm-Message-State: AAQBX9fdG3Ne5nfDIxB48t55RwF51lLWpYCOYQgZqZpSzsPXu/e+uNSx
        BD0qcgYDmBy0aWymmBcF6gMpwclA3BRBWWIo04vn8A==
X-Google-Smtp-Source: AKy350YZXNiBBM1EIRFVqDYPRhTbA1AdBFRq46FGsSzubrD07qtNxFiw40NpzFqHrk3GYLGwWeBqYK6eWi7ePA9PBls=
X-Received: by 2002:a1c:7708:0:b0:3ed:d2fc:2fe7 with SMTP id
 t8-20020a1c7708000000b003edd2fc2fe7mr2187905wmi.0.1681136398193; Mon, 10 Apr
 2023 07:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230410115734.93365-1-wangrui@loongson.cn> <c90c442fe029bfb9c4487284366800b8781954e1.camel@xry111.site>
In-Reply-To: <c90c442fe029bfb9c4487284366800b8781954e1.camel@xry111.site>
From:   Rui Wang <wangrui@loongson.cn>
Date:   Mon, 10 Apr 2023 22:19:47 +0800
X-Gmail-Original-Message-ID: <CAHirt9jXQcvSQPEFgW6B-qeakcRXGFfd1eYCw2g23Fmu4bbS8g@mail.gmail.com>
Message-ID: <CAHirt9jXQcvSQPEFgW6B-qeakcRXGFfd1eYCw2g23Fmu4bbS8g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Improve memory ops
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8AxIL8OGzRkvaYcAA--.64977S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7V
        AKI48JMxAqzxv262kKe7AKxVWUXVWUAwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 8:20 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Mon, 2023-04-10 at 19:57 +0800, WANG rui wrote:
> > +       /* align up address */
> > +       andi    t1, a0, 7
> > +       sub.d   a0, a0, t1
>
> bstrins.d a0, zero, 2, 0
>
> Likewise for other aligning operations if the temporary is not used.

I think we're on the same page. I had previously tested this on the
user-space version[1], but it's not a performance-critical area.

[1] https://github.com/heiher/mem-bench/blob/0083d4e5a82e57939517413da3bcad81e01adbea/memset-int.S#L35-L37

Regards,
Rui

