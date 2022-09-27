Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCD5EBD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiI0IYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiI0IYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:24:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61066B1B84;
        Tue, 27 Sep 2022 01:24:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r20so5562002qtn.12;
        Tue, 27 Sep 2022 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=JumtaG8idfRuPN7IPsQOajX6NdF5kvAB/Ix+jKSGj3w=;
        b=N58abmOnIGGqnlAybUTb6/zEYEJoeCDbvBN6ZDSUATu52v0yGALiq7faPI444bxBPp
         QfKKQ/K9NcfE3RMxaALdup2gleJgCtuqIHWzFuhLDLeqCqosMAT99ZGGwIZUSORXM3YZ
         QzlbyGmblLnFemh+SPTLYKFThhPMvZBYRiVR7WExOAKJLXTKl0S6DSUzmpyaI1pYX6S3
         bi2xDBU/GNYZrR49CeEauOmIjy0B0VAjx1h5Urax0kHHK1qGpH/TsXiRDKJWOI+6pMDO
         6VvsLOcLhybyWNmUIvPw3C0hIdzf/1SCz+2YjzRt9MmuoaAvSwnV7EnA8Lr7CEKhyLzm
         YLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JumtaG8idfRuPN7IPsQOajX6NdF5kvAB/Ix+jKSGj3w=;
        b=U851kVTQXYEfeMqrkXHogbGYnxAXGWCYaA8XzaVYfv22CNYlk5CojIcjDtClke6lYH
         q4d/CW+j20lelxPd2hJM2KQjzaQ3yoC74dIfyROd4qTRwT5vqQIfzMCEmnqWjI32fC38
         PAGqCYuFjQYzkOGtpWBeGmzjNcL32uy898WKK01Oo+0ig5oQCO5AqXUj7QO4bJf1sgJ+
         3516gq54amDZXBSNCBJ20mxqVLItl13Dm9r8D6IUa+paA+28ayyyfu5YHjiDw7Mn1G8M
         ri6rD+LobIwZHDEu2SJkXouSGQ878xZ0KFuppfSPwRXhc447ZY+oHspF++bXR2Ql1AZP
         cMag==
X-Gm-Message-State: ACrzQf0H2bv8kwZ+lQRm3ganTb2UHruK/eQq1+CRC2C5t9SGYHLdf9Ur
        gXha/CvFcAhbxm+KkdHbGuuFSsucOzkHAhfvPvA=
X-Google-Smtp-Source: AMsMyM4cdEyBYxd3DGv4ep5x3l2RfKrLChy4QD9sRS5fzZ4K310L6/eK1kKbo1BQuQk2emvdJqriiNWagfICQslq9lM=
X-Received: by 2002:a05:622a:54f:b0:35c:f68f:44c3 with SMTP id
 m15-20020a05622a054f00b0035cf68f44c3mr20937765qtx.546.1664267044459; Tue, 27
 Sep 2022 01:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220818220245.338396-1-robimarko@gmail.com> <20220818220245.338396-2-robimarko@gmail.com>
 <1efe2f7d-05e2-6207-f4df-5b597d00c862@linaro.org>
In-Reply-To: <1efe2f7d-05e2-6207-f4df-5b597d00c862@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 27 Sep 2022 10:23:53 +0200
Message-ID: <CAOX2RU7C-ocdmBBOoXurh0nrhkntHVHvPsC33DQd9o3FuFAN6Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] drivers: thermal: tsens: Add support for combined interrupt
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        konrad.dybcio@somainline.org, rafael@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 at 00:49, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 19/08/2022 00:02, Robert Marko wrote:
> > Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
> > signaling both up/low and critical trips.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> I'll pick the patches 1-4 as soon as Bjorn gives its blessing for this on=
e
Resending with Bjorns new email as Linaro one bounces.

Sounds good to me,

Bjorn can you please take a look?

Regards,
Robert
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
