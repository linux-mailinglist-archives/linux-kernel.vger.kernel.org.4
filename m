Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2769570D31A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjEWFNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEWFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67514FA;
        Mon, 22 May 2023 22:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A2762443;
        Tue, 23 May 2023 05:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA81C433D2;
        Tue, 23 May 2023 05:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684818823;
        bh=6D94mun2nq2a6rgrNgAG6eqYFY3YSRvDHEm/wXa3MEs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hFXtEdFF5WW1naH8T8Llt7FJKEzdSx2pyK7L4jToO6OTUEWX/FMm5eb98A7uwuVnV
         aFhJHCSM6nKoOTPR+9u6WZZdpaiXerBdz4L1xQEqilyLJZEs+sd0d00LFUzWNaSx+U
         M9sJOS3FvHGhF9fWKhySPrKZoGOV8ciVHJxaLROyPoAHvgX3ObhCN3/VD+9h61d0a+
         UzkVEh5naVWmrlzuulKQG3/o81iBmyE2SbmURIFbzutF7OBhkA45JFJoNe9yjwIfYo
         ViNVUrZ3412DegsiO/QGI14Ig/auT8fmYKIIwm6jRT9Jo59EB/gxzR5YQfOQ9UKVGV
         0+ggE3x3HWsbg==
Date:   Tue, 23 May 2023 06:13:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 0/3] Add JH7110 MIPI DPHY RX support
User-Agent: K-9 Mail for Android
In-Reply-To: <7d4c3c08-6590-5947-92c6-1425c0cb662d@starfivetech.com>
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com> <93d39956-25c9-971b-e73b-09c69e803341@starfivetech.com> <20230522-extradite-nastily-c2a88cfd2f02@wendy> <7d4c3c08-6590-5947-92c6-1425c0cb662d@starfivetech.com>
Message-ID: <039744BB-E0C2-4311-A663-DDDD819A219D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 May 2023 02:02:24 IST, Changhuang Liang <changhuang=2Eliang@starfive=
tech=2Ecom> wrote:
>
>
>On 2023/5/22 21:11, Conor Dooley wrote:
>> On Mon, May 22, 2023 at 09:00:04PM +0800, Changhuang Liang wrote:
>>> On 2023/4/12 16:45, Changhuang Liang wrote:
>>>> This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC=2E
>>>> It is used to transfer CSI camera data=2E The series has been tested =
on
>>>> the VisionFive 2 board=2E
>>>>
>>=20
>>> Can you help to find the Vinod reviewed this patchset?
>>=20
>> I am sorry, but I have no idea what you mean=2E
>> Are you asking if I can get Vinod to review the series?
>>=20
>
>Yes, I need his comments=2E

No, I cannot=2E Maybe you should fix any outstanding comments and resubmit=
?
