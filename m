Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480A35B35BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIIKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIIKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:55:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0156B8F;
        Fri,  9 Sep 2022 03:55:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z21so1945328edi.1;
        Fri, 09 Sep 2022 03:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=2MqAyqB3obT3a9e6Rex16DgbqUANCIruNzkxfEGRAR4=;
        b=KI2cVGDoYMuU2xHbt2FNMPUBioI6v72PhjgPblqD7QrwXyDQqtL+y5TSUwSRpuckpT
         ndgVi0Q5u1f+kwsuJnzPCp0AAzRp6zMVlU6U+qUuhm1Muitu2mtXanPcTpGdvE8Ja79r
         VL/eZU4GCaauqzTStzI/b/fEt9+Jw8hDcLLDz7Af4EwdA5USuy6WnrNVeznbv63iimRZ
         re+0RhzDxVCihZ9f0uUVGMpVBZbscaZdlZKYGtppUexQ95iQ/PlxmBPskdozaeRFqyo5
         FtdHnhJPBvsv428qviDaD9RbBY7Hgkb7D7xAhsHTqE3eNXbd3wTv9ZF/Iia4/KoHrSVS
         qQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2MqAyqB3obT3a9e6Rex16DgbqUANCIruNzkxfEGRAR4=;
        b=PBgDGTxb1CvQodeJPFXbYpZUy9Yp5RzhOMH8VopHHArXU6Buat08DJcdhKW+snihiO
         GGHkqLIY70xBdUu34L6Y14BS9ecchrwbfnzzPeoZjbxcxaSrpccCcNzLOPfzpSnWDyD/
         eQgHzN6Tk9RUgXyTa4dsN187Vt7wDxhw4Vaw095VqJEqg10sXwVQ1x4RE6ZENa3PeTG4
         ZqVV9ikawndK4o0oXnpMcLAmfG4xNqH5e7cF8RDiN7B8Pxj2kg6EBlWOMqRotUYlAXGX
         mzhYRbsS1je1y8ENHO3gYXun5tQSNFO2bNe6vUNQ4mMKUcsYJMq09cJ6Lr1rj9vtXhVM
         uvtg==
X-Gm-Message-State: ACgBeo0KIhwlH7MWXowGOWq80kd6dYQ0g9BHdAOklYgpueaai4wfwRgk
        QYQL3zYqSBEObEJFnhrxrMsPhQN6Cpc=
X-Google-Smtp-Source: AA6agR7IELyZqytBXA7cLf7FxixJI2HrWYysad8iMYuNpf5NEXQi/mkxnDMMuT3z6p/uu3LZ2RHIDw==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr10733719edc.203.1662720906670;
        Fri, 09 Sep 2022 03:55:06 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b0073100dfa7b0sm140821ejy.8.2022.09.09.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:55:06 -0700 (PDT)
Date:   Fri, 9 Sep 2022 11:55:04 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20220909 due to e9e7df88996d ("ASoC: ak4458:
 Remove component probe() and remove()")
Message-ID: <YxsbiCu80EXrVpvn@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of loongarch, alpha, s390, csky and s390allmodconfig have
failed to build next-20220909 with the error:

sound/soc/codecs/ak4458.c:631:13: error: 'ak4458_reset' defined but not used [-Werror=unused-function]
  631 | static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
      |             ^~~~~~~~~~~~


git bisect pointed to e9e7df88996d ("ASoC: ak4458: Remove component probe() and remove()")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
