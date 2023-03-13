Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150A6B741F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCMKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:33:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0BCDFF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:33:08 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53d277c1834so232322377b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678703587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MnFPjolSGcAGgVVAU9LHqJVcOXvL6bwD45MTkZA8cAQ=;
        b=TdRMo4vCxI7jkwffjz992EoyA+NFZIktl9fWEzsvmnu+Enp+kqMtjIKLD9l9Dn3JJP
         lkVtORs8pcVShZUtFiMqgcV0NL3EUkQgkewJqk89nNWE3s9eGD4seV2k/hAij+hLHiQL
         qXdSp49sLBj1Nw6XBo5c6ZfSc35nITY/kaCDdyNPOkx5B5iMeWIFchYcCQuadR4HqXCu
         SimH2y0tnQnXOv7b4LuqLV/woxPW7EeZQsmz4n0oe2+eitiF16/bUrSLdi2uBTwhK1rK
         X2u9A1wcNagflZVXQCHOP68evTXqkRaoVwwOhaDHB4tuhpRpA08IrgnqxvPlO+VFUR0a
         exwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnFPjolSGcAGgVVAU9LHqJVcOXvL6bwD45MTkZA8cAQ=;
        b=UxN1JXTRXYP6DiQKHqC+ymSW6DGg4QVL3QP23mfq2sb1WtfNoyHtcDoacfo0ZNIqtA
         5eYlsoPXzrRAqPZAvrofZ7qgyfB2cIbEVe28HVuAMG9B51omGVRaml6hiba3LyzgJ5z4
         TnTd6hnvfjDhHV0uvnE+rLQ2C62wGwykwIPfBnaMXhqwKItqAVndzltFlH39jhESJr6A
         vrTb2Ry2ReeIQggRdS/oJaFN+87BwCQ4zZHXa5ab0KyNP4tLOMfkODMwUeN0bWWTu+cz
         St7yCiP6aJRNfCzQnNzVM4vwIJ7i3ZZKA/33OPAWiTv+Z+svF0pwTBtTLUc+PR9COuOe
         YXdQ==
X-Gm-Message-State: AO0yUKUCx0YIgCb/0bAdbHEXBgVjSh3M13M43jXygqgXBF2JyUKsf9Rd
        F3Jb6X6tBg/lrMtjOiFxTv3z1k2vBbWQ6DOiMDH1Ow==
X-Google-Smtp-Source: AK7set+p+PXqVfhGIcoeezzILTzkQ5hjANPkgn5fmW12pUVn5gEYBSczeu+L+yu1hgplG+tB9aazX/yuCtoO2JqIJX8=
X-Received: by 2002:a81:e80a:0:b0:541:69bc:8626 with SMTP id
 a10-20020a81e80a000000b0054169bc8626mr4597042ywm.10.1678703587257; Mon, 13
 Mar 2023 03:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230117094425.19004-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230117094425.19004-4-Delphine_CC_Chiu@Wiwynn.com> <CACRpkdY2ohNNJnnFUZscVg1ETEZBOCby7p-B-uCrrGwvLcQZ7Q@mail.gmail.com>
 <TY2PR04MB40328E5E7FC548F3FD207E1083B99@TY2PR04MB4032.apcprd04.prod.outlook.com>
In-Reply-To: <TY2PR04MB40328E5E7FC548F3FD207E1083B99@TY2PR04MB4032.apcprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Mar 2023 11:32:56 +0100
Message-ID: <CACRpkdZCrjWhwcut6AiNdRsyJWFjaz1GgxekYXHhUpcO+iy5BQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] misc: Add meta cld driver
To:     "Delphine_CC_Chiu/WYHQ/Wiwynn" <Delphine_CC_Chiu@wiwynn.com>
Cc:     "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "garnermic@fb.com" <garnermic@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 9:48 AM Delphine_CC_Chiu/WYHQ/Wiwynn
<Delphine_CC_Chiu@wiwynn.com> wrote:
> > On Tue, Jan 17, 2023 at 10:46 AM Delphine CC Chiu
> > <Delphine_CC_Chiu@wiwynn.com> wrote:

> > Why should this driver be in drivers/misc and not drivers/mfd?
>
> The cld device is not a physical ASIC.

Nobody cares about the difference, that is only a convention.
It has a stable hardware/software API that is all that matters.

> It's a controller based on FPGA device and the FPGA may be Altera or Lattice.
> So, we put the cld driver in misc folder. Is the cld driver suitable to put in mfd folder?

Yes.

> > MFS has support code for spawning child devices for the LED you are also
> > creating for example, so please use that.
>
> Could you please guide us which device driver we can refer?

For example drivers/mfd/stmfx.c another firmware-driven FPGA thing.

Yours,
Linus Walleij
