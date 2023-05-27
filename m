Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D07713680
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 23:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE0VFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjE0VFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 17:05:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F5BC;
        Sat, 27 May 2023 14:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35798603F6;
        Sat, 27 May 2023 21:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF29C433EF;
        Sat, 27 May 2023 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685221502;
        bh=pO4NwEQHJ6F7ZIjFw4Ym65Z1i7QKkvs9nTut+QbJV0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFB/48QllP9PKC6JBeIHhB8cfchqrGR7c4nAJ6tMi0BawiJRsjMHi/4JFYT3u/OOB
         Mi45hGvJ7ztIYXYyVLXSXwxA9cMWrsdKnVRbsji+dSstDwYn/e112a3dy+M5bbEERO
         bd+yD2fIc0vdw3iEEgBW66ACsLb7UahjLpt7i8zQIoqI5zeys2ZT7J0gXB5xbkmWh8
         Z9vzq+qjt98cplsrW99OdpMAfVbShRlwVcs9JT+ieLqiMq8eUc1eJOOV7xTd5bL1bv
         tCXrlHQPJISzUjJZVDWr6hDv4G9YcbykXjv7SkJ5yJtC+w7S08ePnqjmk/T9bnVkT/
         P4fmSDWvQNjTA==
Date:   Sat, 27 May 2023 14:08:49 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 04/10] nvmem: qfprom: Add support for secure reading
 on QDU1000/QRU1000
Message-ID: <20230527210849.sd3ycp2pqyorpbpr@ripper>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-5-quic_kbajaj@quicinc.com>
 <68f9bee2-5a5b-2962-6c3d-e73ade371545@linaro.org>
 <CAA8EJppObh3h8sxB_f9SQy7EQ1Gfhe9EbzV=wsUbVNj9PtX=GA@mail.gmail.com>
 <257e11b5-29b5-78c6-882b-ec3bb64ee28b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257e11b5-29b5-78c6-882b-ec3bb64ee28b@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:02:11PM +0530, Komal Bajaj wrote:
> 
> 
> On 5/12/2023 11:01 PM, Dmitry Baryshkov wrote:
> > On Fri, 12 May 2023 at 20:01, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > > On 12/05/2023 14:21, Komal Bajaj wrote:
> > > > Add qfprom driver support for QDU1000/QRU1000 SOCs.
> > > > 
> > > > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > > > ---
> > > >   drivers/nvmem/qfprom.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> > > > index 20662e2d3732..12a7981a8a71 100644
> > > > --- a/drivers/nvmem/qfprom.c
> > > > +++ b/drivers/nvmem/qfprom.c
> > > > @@ -109,6 +109,10 @@ struct qfprom_soc_compatible_data {
> > > >        bool secure;
> > > >   };
> > > > 
> > > > +static const struct qfprom_soc_compatible_data qdu1000_qfprom = {
> > > > +     .secure = true
> > > > +};
> > > > +
> > > >   static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
> > > >        {.start = 0x128, .end = 0x148},
> > > >        {.start = 0x220, .end = 0x228}
> > > > @@ -490,6 +494,7 @@ static int qfprom_probe(struct platform_device *pdev)
> > > > 
> > > >   static const struct of_device_id qfprom_of_match[] = {
> > > >        { .compatible = "qcom,qfprom",},
> > > > +     { .compatible = "qcom,qdu1000-qfprom", .data = &qdu1000_qfprom},
> > > >        { .compatible = "qcom,sc7180-qfprom", .data = &sc7180_qfprom},
> > > I have doubts that this is still compatible with qcom,qfprom. It uses
> > > entirely different read method. That's why generic fallbacks are bad,
> > > one more case to my growing list of awesome examples. :)
> Okay, will do that.
> > Yes, it looks like it should be 'qcom,qdu1000-qfprom",
> > "qcom,scm-qfprom". And possibly a separate driver for scm-qfprom.
> The only difference here is in read method, which can be controlled by a
> single property,
> do we really need to write a separate driver for just reading secure feature
> register.

I presume that if reads are hidden behind scm, then the most of the
driver - which deals with writing to qfprom - isn't going to be at all
applicable.

So, I actually think it would make sense to put that in a separate
qfprom-scm driver, which handles the generic fallback of
"qcom,qfprom-scm".

Regards,
Bjorn

> 
> Thanks,
> Komal
> > 
> > 
> 
