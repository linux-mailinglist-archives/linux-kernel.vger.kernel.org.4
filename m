Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E95F9822
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiJJGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiJJGNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:13:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046A459AC;
        Sun,  9 Oct 2022 23:13:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l4so9501308plb.8;
        Sun, 09 Oct 2022 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhWqAlOQ1Ib05UjQgojKX40zCXEZnCLvPLBoyVNageI=;
        b=kjigfCI8ygwI9K6sw4UUlfNvfYY380KEUPPG9SO+NUjOpAHhFuN3H1UBb/3gSboykG
         MENs8yd8Gj1j32oJnBYQ+g+XPTR32dbqLIkMtwBbrQMltuVKqxpCNV7zutL9qnY7MQqc
         TjvjLYET57TNYCp1C57hh3pXVVH+XBEkrPgkIvJmuxkvMMvRr+Grx8EJf012c0Chln/v
         M3Kam4mOpTAc40MwAVaXMnO6BSWtUrkkU9J4QQGD6zmCFdryu29UN0v4N81+ABXDI5ln
         w68WMxk6aQtvtFBHnCspCcKStV6NR3ya5/nOb+U3dkVmEz46glP7hy7m2+WvISe67FoT
         VXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhWqAlOQ1Ib05UjQgojKX40zCXEZnCLvPLBoyVNageI=;
        b=uU+1hXjMz09I0fP+xpPWUhozWlH6b5seehq2uUPPiHmxvkx1NtGqxJgLkeTdahxZFx
         TD7snt+sC1XJWYVHL+QSUsJWrc63mNAL5ANGX65dYO2vrshV5kWiLvYOfT5U1ij23Ixw
         l4aIek8B/4tMTx1ffWI2aPM1dlrOj+7fPafDh1ThwKLdMcKxXCubVW57ylTuGIShU3x1
         YMK5+wLjAo6UWw8qR6O2rf9Fekq/HrG3WAENYFawrbr/C2z5EJIsf1fWUZ1EBjZXueYN
         XSiZtPr2DNnWzHx3uCAiYYxFftcbaCaB2Q2uiAevTk/ncW8tilonP8Nc4N7Lq0PYkm/y
         8jEw==
X-Gm-Message-State: ACrzQf2MobRv8hzCqGsJSrnrLbhkJu85KAHtqBYYvoKjLUpehTdQUhod
        q42XvcGh+mRD6M22PPNL1NM=
X-Google-Smtp-Source: AMsMyM6mN9mpz9/C+uvfagQWUa9LTCCuanPyMBADfesmZvTjgzvlQpzQ8YHyDYUtCSYE0/bfGg9duw==
X-Received: by 2002:a17:90b:38c5:b0:20d:2938:8123 with SMTP id nn5-20020a17090b38c500b0020d29388123mr8024780pjb.59.1665382427633;
        Sun, 09 Oct 2022 23:13:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1bd8:541a:735e:92d5])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001709b9d292esm5712579plg.268.2022.10.09.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:13:46 -0700 (PDT)
Date:   Sun, 9 Oct 2022 23:13:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: st: Avoid using of_node member of struct
 gpio_chip
Message-ID: <Y0O4GNR28kSOR1Iu@google.com>
References: <20221004125449.67679-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004125449.67679-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Oct 04, 2022 at 03:54:49PM +0300, Andy Shevchenko wrote:
> The of_node member of the struct gpio_chip is obsoleted and
> shouldn't be used. It will be removed in the future.
> 
> Replace its use in st_pctl_dt_calculate_pin() by comparing
> the fwnode pointers.
> 
> Fixes: e75729b2f63f ("pinctrl: st: stop abusing of_get_named_gpio()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/pinctrl-st.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index cf7f9cbe6044..ac24d07338a4 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1175,7 +1175,7 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
>  
>  	for (i = 0; i < info->nbanks; i++) {
>  		chip = &info->banks[i].gpio_chip;
> -		if (chip->of_node == np) {
> +		if (chip->fwnode == of_fwnode_handle(np)) {

Are you sure chip's fwnode is properly set here (without your other
patch)? I don't believe the driver sets it up, and I don't think gpiolib
maps it from the gpio_chip->of_node.

Actually, there is another reference to of_node in gpio chip in
st_gpiolib_register_bank()...

Thanks.

-- 
Dmitry
