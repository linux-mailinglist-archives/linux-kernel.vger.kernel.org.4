Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1E6F0B08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbjD0RhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbjD0Rgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:36:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414B4EFE;
        Thu, 27 Apr 2023 10:36:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b62d2f729so6858915b3a.1;
        Thu, 27 Apr 2023 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682617006; x=1685209006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSPrRqzjKTfa3hSIin6R7kDcOmN9/fb4F3XrRQLNNSk=;
        b=CmilNWaVrgGeMDWGnDWLrL96nyaagp9fK1LYuDbpAKN5n8ExdLxTyJiGG+/hiWEbzR
         UeminMdfH4J/a1+Paz2ChTfmM9TpAFd5GO1LNWDQr5ZJ0uFoIhOD9+ghVB4fGKp2qTJh
         nsnPhG+b008SMLac+1p2CQ1JnymG+EXU3FZWnhCfPxCLPJO/4MBly8xzIJemroslmjmG
         AHd40gNUVILZSg5m/OH7ILO744tMP07WfW3sk3O6R0EawONe/Cne5Z006K7KUDmWuggg
         oCFTPzoPScyD/rCgz/lYihGyRscUKirIT2HM6GX61LFd3jx22AoUAq0p4OEV6n5GQJcM
         YvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617006; x=1685209006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSPrRqzjKTfa3hSIin6R7kDcOmN9/fb4F3XrRQLNNSk=;
        b=hSfbounLqvUlufRSkJiGV8D3lwyuo5VDe20BH6oWoSThgDIDjQv6puMsy8061Hq7iu
         MYOaeEYzxVc71i+3E7NyFa8R1Mf6rZnNEiM9uAjzpHpuC+V1vxNE4qppudWJtncOfA1m
         pLHsYeWZvxnvmewue3GrRU7zoAMWx8nOcd2mAifAEkxC6s7zNmBwrGxhBwPCt8mJyltP
         XtNo0ulXnpTCgIfx1tVNfoR4vjUsOm2XCnV34RIiUbZo/1HBJmbxuB939wWw8Mgby6PI
         HAbg9OEnK99Gj3RmBE6O6EfAm7EDQYhlN4/4FGo7VBGkiPmVyAOJ3/NKRlot9wyMI7DU
         hhNQ==
X-Gm-Message-State: AC+VfDyLDvz45p6wITbnldl6VCN4HyVVBm31e7/XhsPTtfRAD3caqZSH
        s7s+es0MmaV7PVTUC5R22GCsO2YnVvo=
X-Google-Smtp-Source: ACHHUZ4gKV/E6QGhxmD8BAioA1wGruis436PMRQ2CSTP4QqxnHh7zTTP/T0kEzT8UbN1V7xftbfj7g==
X-Received: by 2002:a05:6a00:2d05:b0:640:ddf8:607a with SMTP id fa5-20020a056a002d0500b00640ddf8607amr3095816pfb.14.1682617006227;
        Thu, 27 Apr 2023 10:36:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x4-20020a628604000000b00639fc7124c2sm13790995pfd.148.2023.04.27.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:36:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Apr 2023 10:36:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.
Message-ID: <9809f1da-d911-403f-a2b7-8e102b046ed7@roeck-us.net>
References: <20230426200345.65765-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426200345.65765-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:03:44PM +0200, Eugene Shalygin wrote:
> From: Michael Carns <mike@carns.com>
> 
> Only the temp sensors that I can verify are present.  HWINFO in
> Windows shows other accumulated data and statistics (time since
> installed, total power used, etc) that I have not attempted to find.
> 
> Signed-off-by: Michael Carns <mike@carns.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
