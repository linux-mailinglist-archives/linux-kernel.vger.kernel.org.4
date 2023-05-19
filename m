Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC65708FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjESGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESGMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 02:12:42 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B11AC;
        Thu, 18 May 2023 23:12:41 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso433162b3a.3;
        Thu, 18 May 2023 23:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684476760; x=1687068760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4SN79Akj+b85DVae9qGC3BAR6GQduEBcnLj3YcjnHU=;
        b=Qsb3/9IqTkYzB+lUSxJ3cVvE7+1MtyMYPtChMAICXWgpxGqT+vots9SpUmib8an714
         CZJz52v24Gzp+BRDWKn3BM7tdT9D2EN/iD47wYLypxm39ptgwW4nFyFTV3jiH5lcKlHr
         rq+Ba+zrI0cqk0f5S5h+j8EXlYBrksIn467kc+T0ClnjpH5NoPDldgsFIRFiGCF9eiaH
         XvE24lXpVzmV6py7P5dFXzmdoQt4H+MlLITh5xUl1uOBbR8W+dhXHooALgqdPjnVZjZM
         8XLn3WgE4BAJ4wetf/lCDVnNe0Fbl8y9+mzZsPuCeC3VqTeDIhkU60eWmLmGqI7qtsIw
         dzzg==
X-Gm-Message-State: AC+VfDwxL3kxIHPp5tt9eEEi6SELX7qwDtJaTeJ4nOubsoZaEM2JWWCG
        gMag0pJ+/xy/WXJL5oe0Zkk=
X-Google-Smtp-Source: ACHHUZ4ofhRJDj2vK6lAjY0g6mcB8/BlvmqrFVReEtZMOaB2HN6AWPaKGIiMWBSj5LRDoL1gK+4qgg==
X-Received: by 2002:a05:6a00:804:b0:647:d698:56d2 with SMTP id m4-20020a056a00080400b00647d69856d2mr1842354pfk.27.1684476759789;
        Thu, 18 May 2023 23:12:39 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id f12-20020aa78b0c000000b0063b7f3250e9sm2283595pfd.7.2023.05.18.23.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 23:12:39 -0700 (PDT)
Date:   Thu, 18 May 2023 23:12:37 -0700
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] misc: fastrpc: Fix double free of 'buf' in error path
Message-ID: <ZGcTVfAQeRcOSjO8@dev-linux.lan>
References: <20230518100829.515143-1-sukrut.bellary@linux.com>
 <9194ebdf-f335-4cd6-bf89-bb4f86a57784@kili.mountain>
 <ZGbiwqMxnFFvS7y8@dev-linux.lan>
 <28c6814d-1863-41fa-a471-35a3ccf4447c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c6814d-1863-41fa-a471-35a3ccf4447c@kili.mountain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 07:16:14AM +0300, Dan Carpenter wrote:
> On Thu, May 18, 2023 at 07:45:22PM -0700, Sukrut Bellary wrote:
> > > > 
> > > > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > > > Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> > > > ---
> > >   ^^^
> > > Put testing caveats here instead, where it will be removed from the
> > > git log.
> > >
> > 
> > Shall I add "This is based on static analysis only. Compilation tested"
> > here 
> > or 
> > is it not required to mention this for all the fixes?
> > Can you please recommend what's is the preferred method I need to follow?
> 
> You can't go wrong with always adding it.  The untested part is useful
> to know.  Also it's good to know how a bug is found so we can say if
> it's affecting user and so we can improve our processes going forward.
>
Ok, that's clear. Thanks for the input.

Regards,
Sukrut Bellary

> regards,
> dan carpenter
> 
