Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC54731A34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbjFONkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbjFONji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:39:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DD3C33
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:38:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6584553892cso1906559b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686836258; x=1689428258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNUKvq1f2fPVIon6l0YzXfgd6FlRDBSHq7wAWbzvj2I=;
        b=flAMMBYgJBeFy66IwkkmQLyeg9wKcLCDWR6DRCXb57F1RoUVhVdHGJqgmtxczRH57R
         my6oKxp2XoRguD94TcFKU9RuWK/jweawjfMyeTj49OwhiO/xoaUe8A9S7PNunJXrtfyt
         Az22NNINYuV1WHu08ktHIWdwKFKZ8/0Ek87pqPR3HjrX6novVillhpT8dL0KMEyMygiH
         qP9RkhE3ALnILFlSh7hxfb0jjJv5fwSbEt0vTwlFjRKHn8K6fpycRRIgeS22PrqBzDjQ
         ntS6uuDGIf/dyf+Vf3HaCypsXrvcGrU193xROQqhSNz13cmKBmFSe/jKMmFqBrLuEbOr
         fsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836258; x=1689428258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNUKvq1f2fPVIon6l0YzXfgd6FlRDBSHq7wAWbzvj2I=;
        b=RY2MUVRGf1g3Ow8RFWA2q+n0hkTAP7yyGG5yQ3BV8XY2SqcUKv+o1uwQTnqeNT1dHv
         LGhjudlure2EH+ckUyjULZJqOiXbsXUeCFDtKhWPUz+mk60zFzy+Bu/99QAFXm85yaS+
         N5SL85/E1bE6rvEE0gHSCCS1srwlaOR0t+WiyGgTHwxLW6WZQbxOSlDFdXe1xDw0EsFT
         Le0nVjH2T+/g5kLIEdxYB3nsCwf6i6bnzrRaCY0zje7K6PHpXyc9aeHO5XE1mvwb2AIq
         WEqgTD8cPjgP9+f+ztA0nGC1kBOU5Odt2S1Q+E40pvFA93U2xPA+2HvHlqdQaNf49AiL
         1/0w==
X-Gm-Message-State: AC+VfDwCwMO24YZ1KxAnLkGAjGdLXta+BZAR0YkyEpo762jLnMoMWBSk
        aZ4XWZJzzzICLWl8kjyRdlsBrg==
X-Google-Smtp-Source: ACHHUZ4opAqcTtMFCaB8V993Ma17+PA1z1Sbk4Kq2cSpgeQuBmBHlS1XK5+Dd7Mie0TbM1nvegdYyg==
X-Received: by 2002:a05:6a20:42a5:b0:116:696f:1dd1 with SMTP id o37-20020a056a2042a500b00116696f1dd1mr23464104pzj.4.1686836258489;
        Thu, 15 Jun 2023 06:37:38 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b00660d80087a8sm12009948pfh.187.2023.06.15.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:37:37 -0700 (PDT)
Message-ID: <763cc719-f62d-529c-a1fd-75cb2554a84b@kernel.dk>
Date:   Thu, 15 Jun 2023 07:37:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tools/io uring: Fix missing check for return value of
 malloc()
Content-Language: en-US
To:     cymi20 <cymi20@fudan.edu.cn>
Cc:     "ammarfaizi2@gnuweeb.org" <ammarfaizi2@gnuweeb.org>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615125045.125172-1-cymi20@fudan.edu.cn>
 <34898926-681e-1790-4303-e2b54e793a62@gnuweeb.org>
 <ec762677-f8d4-94ab-e7b3-adee45a052a1@kernel.dk>
 <F5DC6786-D8E5-435F-8FDE-ABD4DD692367@fudan.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <F5DC6786-D8E5-435F-8FDE-ABD4DD692367@fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 7:26?AM, cymi20 wrote:
> Actually this checker is driven by inconsistency, it find almost all
> callsite of malloc() in this module has Null check, except this
> callsite.

1) don't top post
2) don't send html emails

But more importantly, actually check the code before making wrong
statements like that.

The patch is pointless.

-- 
Jens Axboe

