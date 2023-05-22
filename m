Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05770B62F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjEVHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjEVHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22091;
        Mon, 22 May 2023 00:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3048B61DC7;
        Mon, 22 May 2023 07:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874CEC433EF;
        Mon, 22 May 2023 07:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739671;
        bh=lmWU6i3NJC4g5wzn78+kIdxEJ31Orcie7JQOZ6pZMkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INc6zUqBSFZz3GoCqKI6+Zk4JDhHjSgelqL36goyddW+PN60g6FJ+mJHVrr+5ayV1
         zytTen9WyF4cUQij3g8NTHELtklcNHWFPdD4gD8awMOlPH2N93TZBjV9RLg2z1GRHQ
         LNjCoXbi9LV+9gKeMQzFA8UrvgvHds3rBdpm8fUo9SKolCiQbahH7ddQ4FZp+v7CTy
         vHYfDwnigZGt+ADJXxSwJgD2VsAZtpSgKM3CWJnk6uhUgRrpqYDZX/LfFtBG64jk+s
         8E+i0v+W8xdLyejC1Mjve+biZKOLkfeyE0L+3T71qA0ZbbDWQ87arsXfOqONXG4VB1
         w6z0MLIggaP1g==
Date:   Mon, 22 May 2023 08:14:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v4 2/2] leds: add aw20xx driver
Message-ID: <20230522071426.GP404509@google.com>
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
 <20230517195238.34069-3-mmkurbanov@sberdevices.ru>
 <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023, Andy Shevchenko wrote:

> On Wed, May 17, 2023 at 10:52 PM Martin Kurbanov
> <mmkurbanov@sberdevices.ru> wrote:
> >
> > This commit adds support for AWINIC AW20036/AW20054/AW20072 LED driver.
> > This driver supports following AW200XX features:
> >   - Individual 64-level DIM currents
> 
> With or without below
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> ...
> 
> > +static int aw200xx_probe_dt(struct device *dev, struct aw200xx *chip)
> 
> _dt is not fully correct suffix, it's now firmware properties, so perhaps _fw?
> 
> ...
> 
> I would do
> 
>   i = 0;
> 
> here and drop the assignment in the definition block to be more robust

"here" where?

You've removed all context.

> against sudden reuse of i in between.
> 
> > +       device_for_each_child_node(dev, child) {
> 
> > +               i++;
> > +       }
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
Lee Jones [李琼斯]
