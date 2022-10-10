Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939B5F980B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJJGCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiJJGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:02:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5D29379
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:02:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so370919pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/7PRFbEyPK453EfzEHs9WgI/ACZZ1HZWAEczE1Gaos=;
        b=VYT+sII21s7JCXrTK7f8vlrKiW7eDGC2tkd0RBljy8pX65T9x6b54KxJ5MIY74g38K
         9429zo/VIdORK00BIiPZqspZEpRqagnuc3oQUete1NtejsZHZA1+Rn7DlHDVcy0+/2T4
         neKw+lHxwV6NdVq7pHq7VQjur3AODIidyyf6XXkNXRfl7/MexORUG6ahU0E4MG4cKG83
         mnWDIR4Re54nokszPb4sq1mbJJVc6Qdicpl4dJ95pakMHEng5Q0nceXUkdimC4ffDbLl
         jVbetWjEkVzNk0uM/R2T6Q9wvY8yeRrxyi9qEEV1T8spEGebxRcCO51/V5D2zQ2C+0Wb
         6G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/7PRFbEyPK453EfzEHs9WgI/ACZZ1HZWAEczE1Gaos=;
        b=JHPpXYVNSnQQgb3aHaA/QSa93vnVbDlWVHknS/7qbyQP+4+thiShCTuz5+5/0iCjoF
         SvtYONlHFLYOUG+acRhWMJ65Py8ZG1CJlrt3/WrBEv9CUXCUmG95rQTF5gvDhoYMEVf4
         Vl9niGawLHufpFY/LPb9E2GDhTsQWPwY8vahyKVK8VcZDkGaR3jg+hXrihnaTKNxpXOj
         8Rbkz9S8dq3BEEJhoGlmEHJBSJHJdFkUILNg8cgCi8ZakzPHlC5cCpb04xVah7LNEdcr
         7sLplfCS7QbIcXycI9tEpqMjgH55H7Rq9rw96L7ciOr/x4SEujMWFKtTyxGXoa6xatCG
         pV0g==
X-Gm-Message-State: ACrzQf2XL7+IG4vqwghsFuAJ/I4hY8XWcBfrK2rcbcoOzrIC2mUwBSTh
        HXmjyqPAHkfMfVLSBT6sSNvnsQ==
X-Google-Smtp-Source: AMsMyM5FrlS0rah8kfQURYtKcHTU1T20hESr9xhyf/1drQpeN2lwfDPNSVaJi9TPJh8Gz98ik0Yv0Q==
X-Received: by 2002:a05:6a00:27a0:b0:55a:fa17:5cf9 with SMTP id bd32-20020a056a0027a000b0055afa175cf9mr18145044pfb.15.1665381748310;
        Sun, 09 Oct 2022 23:02:28 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id p5-20020a634f45000000b0043014f9a4c9sm5372160pgl.93.2022.10.09.23.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:02:27 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:32:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: qcom: fix memory leak in error path
Message-ID: <20221010060225.bglyfnr274ivu23i@vireshk-i7>
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
 <20221010055530.2mf6lq4mn6zfdkzt@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010055530.2mf6lq4mn6zfdkzt@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-22, 11:25, Viresh Kumar wrote:
> On 01-10-22, 19:10, Fabien Parent wrote:
> > If for some reason the speedbin length is incorrect, then there is a
> > memory leak in the error path because we never free the speedbin buffer.
> > This commit fixes the error path to always free the speedbin buffer.
> > 
> > Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 863548f59c3e..3bd38acde4b9 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -213,6 +213,7 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >  	int speed = 0, pvs = 0, pvs_ver = 0;
> >  	u8 *speedbin;
> >  	size_t len;
> > +	int ret = 0;
> >  
> >  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> >  
> > @@ -230,7 +231,8 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >  		break;
> >  	default:
> >  		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> > +		goto len_error;
> >  	}
> >  
> >  	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> > @@ -238,8 +240,9 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >  
> >  	drv->versions = (1 << speed);
> >  
> > +len_error:
> >  	kfree(speedbin);
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  static const struct qcom_cpufreq_match_data match_data_kryo = {
> 
> Applied. Thanks.

Btw, it will be good to have a Fixes or Cc:Stable for this patch too.
I can directly add the lines myself, just let me know what you want.

-- 
viresh
