Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79D745C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGCMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCMdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:33:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360651AD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:33:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so51028955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688387592; x=1690979592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbjEyULWL6/37XI6VUIi//alYOhlAuf930FnaIS9WkQ=;
        b=OUxAtw5vSPsFxjmXURwGnoN2J9+YjAKe+myiBJmUf9l0ArJy0G5g74/S0IkE0OqvQ7
         pD3Me+8JLQi0mSjPinYFJpzJU+EiElGiWtPALJ2jj91h3K+rUiyc8iqEg4d8NbQ/NxCE
         X5cierhPILETAWsjP4J/5WiFJtFMc9N9BNtCyCqYCKL1f5zf3wjX1oPHVOCdyLxmcGdH
         dMHm5pmnS2sZd4jBI3j6uEKRwwA4Pkbe+iHByS7xQtxPNzAp/N+FSh8+0T39g66XDsfF
         YdZdHvrHd6+OX2QHWXKwtLkGBu/8bvL0DuQn3GBPPe073iCBv2WY/0I4hO9f4DQdaXZp
         5yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688387592; x=1690979592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbjEyULWL6/37XI6VUIi//alYOhlAuf930FnaIS9WkQ=;
        b=R7DBulIozR02Qjs4YFoSnoG4cw21mhY5JwJjaLpWQB/HePJZ2+L/M6XNn8/TAh61cQ
         KhhMibP5iE5GA1RdlExFV1pbOX/y6A8MYQYWqkq/MaHivdjupW3Gz3QGbJPvutblzmEv
         ZS7gS0x1oMU+zLSy9wzkGQ6A5DCU44WJd+ykI2lqkDNfDSurzklpsPb4GuLja4u/rfFc
         XcdBBpDEkbdYU+qGKGbO6ac6IRgHBwKbxsBviUkjakYfdiMNsW91fhCj/PAMEcR8xiOP
         iixc6dlAJe7bnrx2j7WW/9u1+HmTBF4pqCZvh4af0RIHtERRoIqTETfKgxf+fKkB4CBj
         OEEg==
X-Gm-Message-State: AC+VfDw5/xtvU5Vkbs4jBo4XnPgNvzsL6PLlK8FvqSZdT63HBJ211Xpr
        cZliJaglLp6URDrvgp1q4OJN7w==
X-Google-Smtp-Source: ACHHUZ7x89Bw12PK6ySMqwr1DwZdq07oQA0z5Yq+UF7a9FlNp4DufpI7dYWuyaOsbjCMBT/mu1QxUg==
X-Received: by 2002:a1c:6a07:0:b0:3fa:934c:8356 with SMTP id f7-20020a1c6a07000000b003fa934c8356mr9295695wmc.10.1688387592343;
        Mon, 03 Jul 2023 05:33:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm25641129wrb.109.2023.07.03.05.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 05:33:10 -0700 (PDT)
Date:   Mon, 3 Jul 2023 15:33:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Lee, Kah Jing" <kah.jing.lee@intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/1] Enable UBIFS support
Message-ID: <52af3309-2324-444b-99fa-a267509ea4d4@kadam.mountain>
References: <20230703063309.1342330-1-kah.jing.lee@intel.com>
 <066c9c1b-68f3-8f4c-0e34-e31963b45690@web.de>
 <PH0PR11MB567352E337F1C0D099195E3DCB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB567352E337F1C0D099195E3DCB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 07:45:12AM +0000, Lee, Kah Jing wrote:
> > > The patch is to update the qspi mtd partition range for UBIFS on
> > > socfpga platform - Agilex and Stratix10 boards.
> > 
> > Why do you find a cover letter relevant for a single patch?
> > 
> Will drop the cover letter since only send for single patch. 
> Thanks. 

Markus is banned from the mailing lists.  Just ignore him.

You are absolutely allowed to send cover letters for a single patch if
you want to.  Or you can drop it if you want to.  It doesn't matter
either way.

regards,
dan carpenter

