Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06286F1EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346569AbjD1Twy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbjD1Tww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:52:52 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B114527C;
        Fri, 28 Apr 2023 12:52:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b35789313so311706b3a.3;
        Fri, 28 Apr 2023 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682711567; x=1685303567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EU2BEr4GbABZSkfPRSInPaA4/T+uOEil033u9+3n5ts=;
        b=kTqtX4gVsmNn+eqpcHgq5VmvQiBK6Jr66NXl3tvFUFKj15RHUDjIWVpzj2z6HpVVcN
         JP7aTro2E+nU37Y8XmICZnf5pWDupoYW2JPijj6r6MKnhUvzMsMSpr+1H/GU3DAgVndD
         byAjS02d35eqtzh7JQZcDXx7pp0ZXbQ859ZrP5VhyMzDVH3Vt+4N2nmGmzdkB9sHIGj+
         KCV51yLgvCr+vAC8wZbcKWWC4evt0VPZfJE/hONRD86rzscjJl+RkvN5oL5VezD23luD
         UNX76Xg9sIy+TLKPV+QfC5dE+D58CwSP+Iu/FVThnsZilnSNyFboNGY/EXafBvT8yYrU
         b2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682711567; x=1685303567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU2BEr4GbABZSkfPRSInPaA4/T+uOEil033u9+3n5ts=;
        b=DCYD/83RxDm1gZNNqW5Xth19jp96OPq/G52hm/XIDiLzDmZSusdGYmQ0OVaC8D0cKU
         eTBRfEfP2OoUffCQz6Boi5ajqX6UEvuJN8bbmTfKT0ScrPj3AxRNmuS3y8YpK5WjRcZg
         /h2opAOFUUn73oxHcKfly8YU1IaiqRHt6zIRyQnOxt4pwaBFG60sn0IQi0YoPdWdEyar
         RNSDf30AxxOh009FUTAcf7GyyxLMlm5cfhxrowlQFhgdewxGLxM5+zm82RO0lzZNGa/C
         gZXfID1Q0EbI4VZ8V4kJQIfMzyrob1kALjFKS91+TCeEPU9GixmttYwV9xrLSTJMxitv
         mwFA==
X-Gm-Message-State: AC+VfDzzMBci+BbKqMwu0oOX/zg9xTEq2dmlw7osGT2ui4tONstEytDf
        4Tm3hdvoT6MgekIBQNazz8A=
X-Google-Smtp-Source: ACHHUZ4H4SM6cXuxvlvPBr3utkudLS4/JGoUdmMmNd6LWPZoS3wb5qCfdUUO1YNEBKdKpIpK8wCV2Q==
X-Received: by 2002:a05:6a00:1501:b0:63d:6228:6888 with SMTP id q1-20020a056a00150100b0063d62286888mr10163483pfu.3.1682711566874;
        Fri, 28 Apr 2023 12:52:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f36d:d0d9:ea96:1c8f])
        by smtp.gmail.com with ESMTPSA id u4-20020a056a00098400b0062dd993fdfcsm15584636pfg.105.2023.04.28.12.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:52:45 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:52:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Siarhei Vishniakou <svv@google.com>
Cc:     Biswarup Pal <biswarupp@google.com>, kernel-team@android.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
Message-ID: <ZEwkC7BiUpq7kbjc@google.com>
References: <20230427000152.1407471-1-biswarupp@google.com>
 <CAKF84v2Rw8xQv=m+ciL+n_uXhyAZWFmhYpgA63Q=DnVh5sbOsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKF84v2Rw8xQv=m+ciL+n_uXhyAZWFmhYpgA63Q=DnVh5sbOsw@mail.gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 28, 2023 at 11:38:36AM -0700, Siarhei Vishniakou wrote:
> Thanks Biswarup!

Please avoid top posting.

> 
> Just to add a bit of context: we were concerned with  breaking the
> existing uinput usages where the caller might be setting an incorrect
> value (since previously, that had no effect).
> So the 10 second guard was added to fall back to the default behaviour
> for those devices.

What is the benefit of sending this in uinput? It is not much close
to the exact time the hardware generated the event than the timestamp
generated in the input core, so I do not see why it is needed in uinput.

Thanks.

-- 
Dmitry
