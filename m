Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6E5EB106
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiIZTOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIZTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:14:09 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7935597D6C;
        Mon, 26 Sep 2022 12:14:08 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id b21so7110690plz.7;
        Mon, 26 Sep 2022 12:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BzNAI+tDzrvlciPdFpPELa5tc9j3tf6CsQ69ukCNTK0=;
        b=fEd4XMPc9uyAAMgq+XjVDiVV3wV1PMiVgN2QAecm2LHRN07wgYXULvGQnrV+lrhRoV
         SG1VYCnw8BtG2NGVyMS5abDIIFoGV4W82hPAkNqsWRX7pbKEsy7T+bHgrX0LlnCyxvRb
         XyDnthgX1yrF67cKvR/Ik0twpYUBWYv5LdWtOSMqT74O+Isp15/GKBr7FKWT6Ci6Ua4U
         57AXOwupnzOK5vnBlN4nZEhFKD96/r4hX31EejzOuCDZd3+wgRxGy3scANS9fNuE/D0F
         V9oi+66xfnJIQpoEky2KFGjnWXWv2gyltDauavciAWlAXwRP6w9OwKxYgQCi94sxpFxX
         0R7g==
X-Gm-Message-State: ACrzQf1Q3sPlmh30a3p7SbvODi/uXCRm/jcYsQNLFB1b974CevLfvA3j
        MwBLSPv26ump0qFsJDq13kY=
X-Google-Smtp-Source: AMsMyM6tafNAFA665wpJ6H9Ln2LfnaJKnfsdth35oeonk895nSBxA8SrhutQCbD7i0VE8ISUxM9wrw==
X-Received: by 2002:a17:902:e805:b0:177:e8af:ba43 with SMTP id u5-20020a170902e80500b00177e8afba43mr24219942plg.171.1664219647817;
        Mon, 26 Sep 2022 12:14:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a2dc:1c5e:7b78:94ce? ([2620:15c:211:201:a2dc:1c5e:7b78:94ce])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b0016dc2366722sm11449877plr.77.2022.09.26.12.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 12:14:07 -0700 (PDT)
Message-ID: <ea00dcab-e4f6-f672-e754-9ddec67da83d@acm.org>
Date:   Mon, 26 Sep 2022 12:14:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/7] scsi: Convert snprintf() to scnprintf()
Content-Language: en-US
To:     Jules Irenge <jbi.octave@gmail.com>, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YzHyC191CIXZSfc5@fedora>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YzHyC191CIXZSfc5@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 11:40, Jules Irenge wrote:
> Coccinnelle reports a warning
> Warning: Use scnprintf or sprintf
> Adding to that, there has been a slow migration from snprintf to scnprintf.
> This LWN article explains the rationale for this change
> https: //lwn.net/Articles/69419/
> Ie. snprintf() returns what *would* be the resulting length,
> while scnprintf() returns the actual length.

Isn't using snprintf() or scnprintf() inside sysfs show callbacks 
considered deprecated?

Thanks,

Bart.
