Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691D5EFC24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiI2Rhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiI2Rh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:37:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D6123873;
        Thu, 29 Sep 2022 10:37:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lh5so4251909ejb.10;
        Thu, 29 Sep 2022 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KTplSiuNaGRVGHmcAHJDO7FIE5Uxw7tsLd9tBIbz+hg=;
        b=DYQGSel2ZufCHTaQSXdO0yn1SyYdDtR4dy4qLTygu79yK0az/iNW5w3jdP8qVGUcHn
         WL730l/ybcQhuB/mlHalJX/1m2Pe25iZ6rcZ5aP54T8C0A6ZcAxt2FHOgAC4Zs3LsY/R
         DnQ5D/t2SZU7NKOu/FvPzzvvs6kgx8mYmHNNvUvQWjHKzjtCfqJnDXvA/wb9DPlbn+42
         3N+BCjNxUW0PlSG4o+F8r1wmseep5a4kWhyUrUhQ21jKC29oxAyUmuf89jd+KLQNGu7i
         bdiQAqTaQwR3Qy93S6gw6nMO8DeIOOVjX8sdUes6CKmwOwPXfnVQs+jwOLtYLwKqoeHf
         cC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KTplSiuNaGRVGHmcAHJDO7FIE5Uxw7tsLd9tBIbz+hg=;
        b=Fquyqv0Z92u295UUDR99EOLKCOw/aoNBArIzny5FnzyPuVjlS/dueIr32Yf1T2qeHQ
         sIfQ1n0P4mjWS3faq7KYxDTv+6T/qkedVtkGgBNOOPtpgh+4/28tkd2kynIRPmCjy58u
         24XjaQigMORQfUe5ZZtlrn+4QH/JV1KjiS8ikA+y+o9NlAkZntmq4P5/OGhpj1wgnerE
         lQ/lppYfZLyuJ9xeqi1IR93m7EARQjwbMMwdAs27kvUdoR2YUMYUL9emwPQ1bRPxMrQI
         iMKrQDUqxw/7OvAUfT9c3vKaCG9I3LZIwq/zKQjGwwhhwHHeubjhyyF+n7AVsHfVfhBK
         l/IQ==
X-Gm-Message-State: ACrzQf1ECjA4wvLBDscW2pG23zh9AfAY25DbVVMlI69flDXXcxxDUJPt
        +KWRDnjlTi7Gff6EpljnRAdP79QbmC5W5S4vt6c=
X-Google-Smtp-Source: AMsMyM6aGtWtfOGB/Y1qKHkRPOm1mZ2Yq7f131+BT1uIusPPyrIpcDWWzgTfBm8jX7auWSp9ZBIpCftQSZ5TuUXn7u8=
X-Received: by 2002:a17:906:8a5b:b0:781:7009:965e with SMTP id
 gx27-20020a1709068a5b00b007817009965emr3470982ejc.625.1664473044320; Thu, 29
 Sep 2022 10:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-10-quic_eberman@quicinc.com> <20220929165908.zgmlujhp42ihine5@builder.lan>
In-Reply-To: <20220929165908.zgmlujhp42ihine5@builder.lan>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 29 Sep 2022 12:37:12 -0500
Message-ID: <CABb+yY1qpMdvfEwAFphYJJVvAQiNj7_gRmkRk38xx_QXr_qPBA@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] mailbox: Add Gunyah message queue mailbox
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:59 AM Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 12:56:28PM -0700, Elliot Berman wrote:
> [..]
> > diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
> [..]
> > +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> > +{
> > +     struct gunyah_msgq *msgq = mbox_chan_to_msgq(chan);
> > +     struct gunyah_msgq_tx_data *msgq_data = data;
>
> The mailbox framework abstracts hardware mailboxes and @data
> should be the data to be written to the hardware.
>
> Using the void * to pass composite data types means that the client and
> provider are tightly coupled and as such the mailbox framework does not
> provide you any abstraction.
>
It is so for every platform, because there is no "standard format" in
which data is to be exchanged between endpoints.
Mailbox api is used mainly to avoid redoing message queuing and
response handling.

cheers.
