Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F956E6D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjDRU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjDRU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:27:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6D9F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:27:44 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f7c281a015so1752947f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681849663; x=1684441663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1h5VMD8irVNgEXz9YvfZ3zmENpujirJNHAjn+rYAZE=;
        b=twMxLwYOZ6dC9LrYkN1FQPYT1IcxPWPd6k0ixiWIZHb7qZscLoKqG7eabN3ZU/rsFh
         2M+I2xQaOcgP9vhaYR9qr4c19iBxlCOu/q/hxy1UJOwtnAh0BnSMoFfr+dqy2JTgsD1z
         ou6giTAVLv7aIBcjvnj5ncSAnb5HS1Oe8BjwVZe8eQ4HluDCrjoO2OR+D+a5pN0ojavO
         2nGLsAKvWML5zjkuOQfyoVeIpVz/6iEDmuILxZRtKdQSt+f63ebVZTqpgAbzPriyjQKM
         CgDKE/jU8PbMKVOr2/Sd1d/g7nlB+ckoHqacVEB5Lr7Eo0PzaAcMnf89tSID4IMbNZdx
         7CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681849663; x=1684441663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1h5VMD8irVNgEXz9YvfZ3zmENpujirJNHAjn+rYAZE=;
        b=cElrwEo5KDlud9lMLoLgXHxUwNIUAAGSnqOnaQlJ/QAUJvlXD+oEYjJwTG81oNzLLB
         6sFjau8n1RNZZTWYQoNllF4/M8SSzhZrkV4CaATMtHm76L0Zc20/uebF0IfD6oVcHbQ7
         ZKyRTZDdaswnubIqcceM/KAgMKS2Uo75TfOWGpXl4IDGTEwpvZm41gkREjWWsjjw1lKC
         URo3q2cE7dVK3E3LdMWkH8btwjcJ6khx/psYqQLa3Wn2J/yWce6sGc7FG1kRQhOvZc5x
         3LxCrEB/ThNx8XAqj0+GsOL9tRlzlGD86Aqck1s4YlQuYRGYSM6DlGWqEP7fI9VV0yUL
         Y8AQ==
X-Gm-Message-State: AAQBX9eDvQNJ8ai2waOks8qRwhUx0IIm/oxdH5O1NPXDdVTcbURNHx1M
        JgWvQu1clndJSVYuRMMEKdrn+dPtsQgEtQSky0tKiA==
X-Google-Smtp-Source: AKy350ZMNx12ahTSkdJmMl8y+SwQf09SwN6gvR+KA+aItA0HKnicjt5YfiKc5zRaeURVS63fe96kFZeAwtS5U6Kfu5A=
X-Received: by 2002:a5d:4f05:0:b0:2f8:cd53:d882 with SMTP id
 c5-20020a5d4f05000000b002f8cd53d882mr2271901wru.56.1681849663050; Tue, 18 Apr
 2023 13:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144736.1546972-1-robh@kernel.org> <20230418162635.GE1764573-robh@kernel.org>
In-Reply-To: <20230418162635.GE1764573-robh@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 18 Apr 2023 14:27:32 -0600
Message-ID: <CANLsYkyUorJZyfiKA+ZpF0aPSxx7nU4f3B2f+S5Y93GnZshG9A@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: st: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 at 10:26, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Mar 10, 2023 at 08:47:35AM -0600, Rob Herring wrote:
> > It is preferred to use typed property access functions (i.e.
> > of_property_read_<type> functions) rather than low-level
> > of_get_property/of_find_property functions for reading properties. As
> > part of this, convert of_get_property/of_find_property calls to the
> > recently added of_property_present() helper when we just want to test
> > for presence of a property and nothing more.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/remoteproc/st_remoteproc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ping!

I did provide an RB for this patch on the same day you sent it,
thinking it was part of a larger refactoring effort.  But taking
another look now I see that it is not the case and will apply it right
away.

>
> >
> > diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> > index a3268d95a50e..50ef40671652 100644
> > --- a/drivers/remoteproc/st_remoteproc.c
> > +++ b/drivers/remoteproc/st_remoteproc.c
> > @@ -379,7 +379,7 @@ static int st_rproc_probe(struct platform_device *pdev)
> >               clk_set_rate(ddata->clk, ddata->clk_rate);
> >       }
> >
> > -     if (of_get_property(np, "mbox-names", NULL)) {
> > +     if (of_property_present(np, "mbox-names")) {
> >               ddata->mbox_client_vq0.dev              = dev;
> >               ddata->mbox_client_vq0.tx_done          = NULL;
> >               ddata->mbox_client_vq0.tx_block = false;
> > --
> > 2.39.2
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
