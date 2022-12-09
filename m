Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19610647FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLIJDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiLIJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:02:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADF9588
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:02:44 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so9996500ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ml4uQdL2LKYdwrPVo83/jU4ECyqWWVioxy8YQNnT+VY=;
        b=nh4kgLU1fvGyfQXiNVbiwBL5S6HGfrA3MKIcKYxklaF/kZle50Ivua9dSIeZfdN8A4
         OK6MkEd4xG8Yi4PMYk9d96G5UST5rsE+BdbigsZ0JaUpPMh9KlPyNz+Mm24my4YWrA6a
         mwT4GYxdfdd9UQ70QEtxnKdyYZW1VJ0dVpMzWqY+nsrkPSb1jrs/I5RfKRA94KKWLsH3
         geW6/PN5dNTRimPmKktXV10ZinWHAtB/4b92KamM6BIrA/qcCwQXHF9oPCP4n9xzrlfc
         oJiSCT+K1b1RPMwaWaZsXcee0H1+uk/2sQ1bDXejsqb/plkHhC1FUZ6wU1xZ/l7mWtrX
         ZC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml4uQdL2LKYdwrPVo83/jU4ECyqWWVioxy8YQNnT+VY=;
        b=Dku2FmClswQePnko0gLirOV1mcHEtFfaLjy31i8lMlAvu0jdmu44545fhpdJs7xlVp
         oZYbDxKSPwexfXt9jYnXpU9T1bhS8zGAetHRYuwd/UixNKP/OKBJpHhRtV+yBnKucPVm
         K22x1/i+ACAN8GGqiwwmptIaND9UXkbgrT1O+xACdjzK9q5ObByyFD8Dq3TouXCkivpV
         zaCBOx8IeyMNV53xDpfbSblvMvleN5QpwUNGkJif3/oghmkQ0JCmnkaLo9nlav1mA9/O
         IhH6vfrRUM1ZRwmgIgStP7TGFgZ3FNE44SQBNwFKpX+Zwj1xag3dXP0fF4Ae5SbDCwfz
         NcFQ==
X-Gm-Message-State: ANoB5pkA+4QwqtZfMprxWB4Tizxe7yi9djw5KHbAiVR5lYHROXlm/eFN
        iZ89QvZubHhMYNCW7gMMjdJmD+/5O2wV/ty8l9Q=
X-Google-Smtp-Source: AA0mqf53770UPgeL0qzpYQ90NARZ+cIC/EtfK2+HzPk91Z0JCm8/vUT7SlGUvJNdDP0ajwpOXz+Mdg==
X-Received: by 2002:a17:907:9712:b0:78d:f459:7186 with SMTP id jg18-20020a170907971200b0078df4597186mr8592530ejc.49.1670576563293;
        Fri, 09 Dec 2022 01:02:43 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b007bb32e2d6f5sm295193ejc.207.2022.12.09.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 01:02:42 -0800 (PST)
Date:   Fri, 9 Dec 2022 10:02:41 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     yang.yang29@zte.com.cn
Cc:     salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, brianvv@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH net-next] net: hns3: use strscpy() to instead of strncpy()
Message-ID: <Y5L5sZy3ks3MxYsM@nanopsycho>
References: <202212091538591375035@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212091538591375035@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Dec 09, 2022 at 08:38:59AM CET, yang.yang29@zte.com.cn wrote:
>From: Xu Panda <xu.panda@zte.com.cn>
>
>The implementation of strscpy() is more robust and safer.
>That's now the recommended way to copy NUL terminated strings.
>
>Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
>Signed-off-by: Yang Yang <yang.yang29@zte.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
