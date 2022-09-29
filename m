Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49D55EFC93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiI2SBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2SBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:01:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E32E1712;
        Thu, 29 Sep 2022 11:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14957B8261E;
        Thu, 29 Sep 2022 18:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0995CC433D6;
        Thu, 29 Sep 2022 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474506;
        bh=8kPx1R+nzlwzeGOnOVa6U8w+cN8OtIbZrTk9XJl4ZPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOeEtd3yQKKExfmgIbEwcT7E4lywbxhgdir4oc/A2OJQM0mX7hAkb6i/hiezadYe/
         KQnkuzSxgz+BodeswtnfcLndYU89vEtGuq83G8eKN7TKfha8YgbgG3HB+avSpGJgJv
         hJUlWOhsGvjDk9saNxPZhUa9JF6nSgIoHUlu74QY5FxbJ8cYnZEOJcUmVTr3uRZmMT
         xA2AJLrZRtSi7tYa6GSMNkS+l81Glwn3+7wj79+suwPpJNMK0G7dVvLNealOTQ5eDu
         UBxamd+Uwgwj5EHOwHycZALVDRIOYtGJUy13+pCZV7eJ12EMOVbpEzj0ye287fjnSI
         bz2GbQx5xGl4w==
Date:   Thu, 29 Sep 2022 19:01:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <quic_c_skakit@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Message-ID: <YzXdhVN/Zp7DDIzB@google.com>
References: <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
 <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
 <CAE-0n528QaTtZFp=WAaHShegFRpKVN_67jQfUJTtsRPr6s--zA@mail.gmail.com>
 <52039cd1-4390-7abb-d296-0eb7ac0c3b15@quicinc.com>
 <Yuz2O+lZ5W7RviuA@google.com>
 <CAE-0n507SLeYB7XVzGFk=RO6YjOPoGpux+_N2AyrmL354mQJ-g@mail.gmail.com>
 <YzQf7hf15vvLeGse@google.com>
 <CAE-0n50cX5ky3By976RTecKkpeMoAjoBA4tYuWSZ150JfS9wiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n50cX5ky3By976RTecKkpeMoAjoBA4tYuWSZ150JfS9wiQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022, Stephen Boyd wrote:

> Quoting Lee Jones (2022-09-28 03:20:30)
> > Wouldn't it make more sense to simply separate the instantiation of
> > the 2 I2C devices?  Similar to what you suggested [0] in v9.  That way
> > they can handle their own resources and we can avoid all of the I2C
> > dummy / shared Regmap passing faff.
> >
> > [0] https://lore.kernel.org/all/CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com/
> >
> 
> You can continue reading the thread[1]. My understanding is it's one
> chip that responds on two i2c addresses, thus we don't describe that as
> two i2c device nodes in DT. Instead we describe one node and use the
> dummy API to make the second i2c device.
> 
> [1] https://lore.kernel.org/all/Yk3NkNK3e+fgj4eG@sirena.org.uk/

As Mark says, it's probably 2 separate dies that have been encased in
the same IC and are otherwise unconnected.  Not sure I understand the
comment about not requiring another 'struct device'.  It will still
require that whether it's a platform device or an I2C device, right?

-- 
Lee Jones [李琼斯]
