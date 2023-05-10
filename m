Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7CC6FD356
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjEJAnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjEJAnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:43:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9D240CA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 17:43:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab0c697c84so50406135ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683679409; x=1686271409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB5BvKVhpQvSgLgVUrNJenXGRMdvldh0g4Gcs6bhWrE=;
        b=HPbYKMQ5Wg+g7ufWpMTcp5rqPsA91Fr6NLQntWXMkEfvXTuYKggZYysFqLT2A/WB1T
         GI2PUYjbL1t1r9urkgHIh8iWlyzJamQLQzh0+ArEF0HwKpT16yAguf+AEUMNYpiyynxz
         Iad/X7zYJhQRlHFHfTwlUlcktR5AOmjBf5fa3vsgoj6IOG3NuM92pqD7hQ7aW60a+W0O
         z+IZUPdq2jBcRM6NLPTMeOBzVvkKqQXs4uKq8CzuXYJ1dA9aHsoEduOMZSIzXBN/uZ1r
         whYrqQ3MBiXSrF2/BpUdkDBoolAJ2UnUbZdg7f0IVS4xyLRFuyQnSrSl4z91anehu/yk
         nryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683679409; x=1686271409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB5BvKVhpQvSgLgVUrNJenXGRMdvldh0g4Gcs6bhWrE=;
        b=PT6OP0AXHWJsmc7Y9zKmUkMZ4khNBB9vDfJhC5U3McexQpB0h89pIOpLv3V8L0rSQ4
         6sLLT5zCbAn7kOeOk3WDZdZYtLDHg+efUkSr1dx9LN5GyISnAHGNpOx3OHokV6c9uHDB
         u3EHeuSTlaOe28GOfDHVaCYmbq29OJlvXBQdPOOhsY1Lfgn8c1sH3NtbPavDzyX2WxYY
         DnLm7/TMg9qFdpCHwcyrhMZpZ2Zw92pX3m5li1VgFPmz5TOhYGcOzZtXNpyOEblpZj0c
         q5J06+sNtYdEzHJbWaPzsRLQo9qpO+xrQoOUjD6iXjS7Z91rmtS9P+Z0FMlA0qZaEYk6
         m55w==
X-Gm-Message-State: AC+VfDwHwVJRKGEnEtuLid+7aLUdr61isEdsivI4OUgJmaefIoaxA+/l
        HcQvgjHj2cIRiO0/QEJTg0OTCwmv/Ik=
X-Google-Smtp-Source: ACHHUZ7eqxLfsHQns/lKbthdAm3VjUaNgtCiQfxUlk9DYsKHiUkyAq6NgV3Z7//QdOq2xG92FfNlYA==
X-Received: by 2002:a17:902:e801:b0:1a9:a3b3:f935 with SMTP id u1-20020a170902e80100b001a9a3b3f935mr21443981plg.57.1683679409012;
        Tue, 09 May 2023 17:43:29 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001acae093442sm530732plp.82.2023.05.09.17.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 17:43:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 14:43:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernfs: Prefer strscpy over strlcpy calls
Message-ID: <ZFror6rRtvHFi9Tj@slm.duckdns.org>
References: <20230509223036.3007500-1-azeemshaikh38@gmail.com>
 <ZFrK9Vw9sbE6NSLi@slm.duckdns.org>
 <CADmuW3VAP3-oZSK5Hix5sk62+bbwiCoC3MFoFHmBd-OwXS-pHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmuW3VAP3-oZSK5Hix5sk62+bbwiCoC3MFoFHmBd-OwXS-pHA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:40:08PM -0400, Azeem Shaikh wrote:
> Thanks for the quick response Tejun! I forgot to include the relevant links
> in the commit log, sorry about that.
> https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> mentions that strlcpy is deprecated and should be replaced with strscpy
> instead. https://github.com/KSPP/linux/issues/89 is the relevant security
> bug which aims to remove strlcpy from the kernel entirely.
> 
> Does that help justify this change? And if so, would you like me to resend
> this patch with the relevant links included in the commit log?

Yeah, I think so. Please explicitly state that this is a part of tree-wide
cleanup.

Thanks.

-- 
tejun
