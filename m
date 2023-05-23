Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD670D47E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjEWHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjEWHF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:05:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8938D109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:05:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3093a7b71fbso6702683f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684825552; x=1687417552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lK0FbIRIU3vRu14qlzr2pPFF9QsFl229avcXo3OZVb4=;
        b=ltWNi/Ovu+Y0LtOwMv9XC7UwQCaBPib0inFJtmQUu6FWYA8voz0YkccytfW/HmsUT0
         dIkIs2pMYH9iBuS5JZUABVjx7IfXXz6kJ5nBuaQLVRfhIuIAsO42iJUzptnrW/qn/6cS
         jh1WrWPm9G+lRFljum30CIDHkyCirMKPSAoYq3jbLlBFpBfNeKmD5p1oWZMPr+U/zHBn
         3hDaYJPOzT/w4tXOAtx5m1jqDhdUMorK1DSCLJ5iSe04LKaDUdmeBmuwyNJ5vIIRMBN6
         zDgF8xrHafaxpwhzuiGVboPWkdpALW8qF/OlYzErq9ka+TBUuJuzbPgJoFO1/NcvicMO
         ohxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825552; x=1687417552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK0FbIRIU3vRu14qlzr2pPFF9QsFl229avcXo3OZVb4=;
        b=VajyeNoMMXrWG6sXIhnqhBBxcxYwUwLsPxqAlqUprlmcO8epJys28hNLjOVVpDEkst
         B/8QOEOXt/QecFjMxnRyRDLG5J2ldg/15hY0lTC0E4f0STRPuwRlaaN5dVBd/sCGoJE8
         xY5An+yhrNvEJs/z5JDO6fIjxQgzhi9Cu4lu3A+0Ju9icII7siGagIHT4Hjj+ZzIoAle
         WZcbm+JkQNxrAWgkAmyGx4StgxRE5xJ3YsGBCCX5T9+8632UJpHCM+PemXTsxPejByUL
         1B60zRuVSIEQSoL/FxQw7pwSTa+tWA1O01lZuAD6rO5t/Gh2StjS+J7zqX+cAZKaTqLC
         RLzQ==
X-Gm-Message-State: AC+VfDxaoogxD8jHIDfJrgR4mwdV0HEfAKk2ckgdyhDh51274MY2gWtC
        C5krYqzOL6cUJTQ4p//f9RiIgw==
X-Google-Smtp-Source: ACHHUZ4iZ9w3Br7aj/u4JCbG1/68MLmy50VAHu+zhSShAqCVeTRVEy8L0hvXV+NBg0asbp8H7v2myA==
X-Received: by 2002:a5d:40cd:0:b0:2c9:e585:84b0 with SMTP id b13-20020a5d40cd000000b002c9e58584b0mr9015110wrq.1.1684825552047;
        Tue, 23 May 2023 00:05:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o2-20020a056000010200b002ca864b807csm10278389wrx.0.2023.05.23.00.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:05:49 -0700 (PDT)
Date:   Tue, 23 May 2023 10:05:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Su Hui <suhui@nfschina.com>, Jeremy Kerr <jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>, eajames@us.ibm.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cbostic@linux.vnet.ibm.com, linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH] drivers/fsi/scom: Return -EFAULT if copy fails
Message-ID: <413f4e50-b722-427f-ab30-d320efe71cc0@kili.mountain>
References: <20230519013710.34954-1-suhui@nfschina.com>
 <de9a7ffe-bedd-4181-886d-c9a3006b7be8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9a7ffe-bedd-4181-886d-c9a3006b7be8@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:30:06PM -0700, Guenter Roeck wrote:
> On Fri, May 19, 2023 at 09:37:10AM +0800, Su Hui wrote:
> > The copy_to/from_user() functions return the number of bytes remaining
> > to be copied, but we want to return -EFAULT to the user.
> > 
> Why ? EFAULT means that a bad address was provided, and it is not
> immediately obvious why that would be the case.
> 

Right now the function is returning success so that's definitely wrong.
The copy_to/from_user() function will only fail if a bad address is
provided so -EFAULT is correct.

There is a different Smatch warning for when people return a different
error code such as -EINVAL.
drivers/fsi/fsi-scom.c:337 scom_read() warn: return -EFAULT instead of '-EINVAL'
The return affects the user and -EFAULT but that level of pendantry feel
like possibly too much?  There aren't many instances of this warning.

regards,
dan carpenter

