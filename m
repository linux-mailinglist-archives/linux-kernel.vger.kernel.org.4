Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A36FDF79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjEJOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjEJOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:02:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E931737;
        Wed, 10 May 2023 07:02:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7575ff76964so232992285a.2;
        Wed, 10 May 2023 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683727363; x=1686319363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KK7toW0GxrS+3AbBvB0r3JQASW0mB3w9AKkm07q+qQ=;
        b=ExvNcGTXoImNu79RTZOLFIK1ZM6xm75ugFk+pwpV9CLtQuymEdjH6yv0PU1DEREBkw
         1ENY6CqIi86McUVdqzLbiymFVHePdNsKPlW6FTROl+eILgfA3crTqQVWYX+nvWzrQXO6
         Y+HO9Gjp8tdvDgqPh2ZYVKEOGt07oE2zP5jhriFiSuJRDki5QkRj2HF30FeS9ivK8yPu
         px6Ylgzmj4YGzt6/FGqC/BHUbmJE0dS/UziZHXAnlvrZCeggmy1a6M1XKMdj/HB096K5
         wzxxGWDR007MIeXCTAYmF+8TfvwhJ2dG+ejaL1XPY5Z+ec5gu1JB99KuI/cJQ/qrvBHQ
         6pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727363; x=1686319363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KK7toW0GxrS+3AbBvB0r3JQASW0mB3w9AKkm07q+qQ=;
        b=JpJCA0VXsfVJjZ1WDiL0N5sO0Xz3GzjLpXU225Rs3GkhrXnBoK99M9sGQ4X4nnc8Vk
         eqcN+Y7OA5nVBKeT1tcYlyhPUeozDKregf0luRhx9rwX0+1rZiXBkN0AeQZHy/UtJmDX
         cyyyp2nYB/N4a9wCsDt0soQuo9O1LJvfGb51HLaKq8GwAESLqorfEkvrTrvoq3KjPKYH
         5yPEHSveAQraT3dfrUC2WewJcJKykfDUUQQpPL6vrua5GLf36gNp8jugXG0qNwNojm+A
         QyN6+bjtFhbp83URiy/paVM1j8aGP49tsqRpSqJlSFH/eVJBnVzYgHmFbYubOe9h11yg
         IKrA==
X-Gm-Message-State: AC+VfDzse7VmLKUON/fmOK9UH/AsqK1iZOMi2ow/eYUJ21zR3iRybRQq
        PXA2B4jeXYReF7NGJz7PmOKFr00OedR61WWro8IhNjCYRJjQ9w==
X-Google-Smtp-Source: ACHHUZ4UWmVM2eDvl5HZzRywh18VPeYpaacqbJLeNtVFxF90Kph9at1vsO+iHul9QXWhtnzVBXUjKz+zPp9ZkbSKzVY=
X-Received: by 2002:a05:6214:c6a:b0:619:a7e3:99e2 with SMTP id
 t10-20020a0562140c6a00b00619a7e399e2mr20125446qvj.17.1683727363525; Wed, 10
 May 2023 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <1683718725-14869-1-git-send-email-quic_rohiagar@quicinc.com> <c0c3db1d-e83c-3610-ed61-db84cd88b569@quicinc.com>
In-Reply-To: <c0c3db1d-e83c-3610-ed61-db84cd88b569@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 May 2023 17:02:07 +0300
Message-ID: <CAHp75Ved53idRgpCDb2c=Bq9HXaE+sOWpY256rSRz-6bfRYnqA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add pinctrl support for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, richardcochran@gmail.com,
        manivannan.sadhasivam@linaro.org,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 3:16=E2=80=AFPM Rohit Agarwal <quic_rohiagar@quicin=
c.com> wrote:
> On 5/10/2023 5:08 PM, Rohit Agarwal wrote:

> Patch 2/4 didnt go through in the mailing list linux-arm-msm because of
> char length.
> BOUNCE linux-arm-msm@vger.kernel.org: Message too long (>100000 chars)
>
> Here is the link for it.
> https://lore.kernel.org/all/1683718725-14869-3-git-send-email-quic_rohiag=
ar@quicinc.com/
> Please suggest if this patch needs to be broken down.

Since lore.kernel.org has it, I think nothing additional needs to be done.
`b4` tool will take it from the archive.

--=20
With Best Regards,
Andy Shevchenko
