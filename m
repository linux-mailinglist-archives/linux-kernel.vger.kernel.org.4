Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D346C7540
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjCXB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXB4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:56:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D223A77;
        Thu, 23 Mar 2023 18:56:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bc12so609071plb.0;
        Thu, 23 Mar 2023 18:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679622964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZYiqLSuCenJlaKXqVI0jmyYBL2WMrO5mS6Gb1s2FKE=;
        b=IT1GpuPh7NaGwzTdbMNriSlXmhpjj4qZcnvT7sWXbNI9b+Qx3IkXEBWJqKrcxM0nRX
         N/EYRJk8ghSmr3Km0lvLpaaVAMUZscklPbJ/1s6/8OamEnj8UhBndmqimw4Oe9IpMprr
         OtLhVYG2inOQuUZDQ/WVHCIUasHFhg0XIOqtRPqmV1luFnix+EPGgNfLRFWEnmLBrGlC
         riVJraXgZxBHxBdRcLWQBLm8rljjsI/5zUCiDu78iLtNAl6PTq999M/V56EEAUlfhD4Q
         vE3iJnSP9djKIN0OygaTO7Txyt28gqvtZCvVoqsjEBEuQk8bgsZ/wIIi4m82GC9EJQKD
         8/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679622964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZYiqLSuCenJlaKXqVI0jmyYBL2WMrO5mS6Gb1s2FKE=;
        b=gJaodZTEorTtONdmbxkDrm+jU5PclVBPkWK/yp2jOEsgfJdqkuxBw8YmUN60NRaFYH
         tHYlBj4/afRYC5KUBNYE+zT5r20qkXvxyPQetXT53b+nCVNzgxxHYavLe0730iCa2sQl
         PLKZ8m14UgBNsiQ0xyao3KxUxJNZZkhw0l7NDKVsmuOqk/2zMTnRhEGbT32gr1BMsgaR
         RDwjadfKvyvwKu7DPMrZtpMcUZnM34FaDCL7WbTOseoRRRTr82M0actBXoHW3QHDSSUi
         Rh5fz9oQ16kc8vvLsXWPMsRmPN+7FYvodD+Zb8829XSkluzmU+3iFyLMg5bmaGH9Rceh
         DHRw==
X-Gm-Message-State: AAQBX9dGuroyy5WFAmYc/wmPPLZ1j1S7g87m4YqU5gJ0YqUCQQZUZqIS
        QRsKe3Ihi6X3+scOKNa8FxUKFfnrC/Q=
X-Google-Smtp-Source: AKy350YoxEypB2cUHdYZySglgUGHruR1SH5C6jGK93IEqr6GH8+C/vjONsmv5ECFGw85WJpPmQZA4g==
X-Received: by 2002:a17:903:32d1:b0:1a1:80ea:4352 with SMTP id i17-20020a17090332d100b001a180ea4352mr1231589plr.0.1679622963713;
        Thu, 23 Mar 2023 18:56:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ba8900b001a19b6ccdd4sm12953132pls.84.2023.03.23.18.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 18:56:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Mar 2023 15:56:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bw365.lee@samsung.com, yw85.kim@samsung.com,
        huijin.park@samsung.com
Subject: Re: [PATCH v2] workqueue: Introduce show_freezable_workqueues
Message-ID: <ZB0DMoY/+mmk+5NU@slm.duckdns.org>
References: <CGME20230320034829epcas1p2a88958d53a51693906020bb5c2b8bc28@epcas1p2.samsung.com>
 <1679282945-37120-1-git-send-email-js07.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679282945-37120-1-git-send-email-js07.lee@samsung.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 12:29:05PM +0900, Jungseung Lee wrote:
> Currently show_all_workqueue is called if freeze fails at the time of
> freeze the workqueues, which shows the status of all workqueues and of
> all worker pools. In this cases we may only need to dump state of only
> workqueues that are freezable and busy.
> 
> This patch defines show_freezable_workqueues, which uses 
> show_one_workqueue, a granular function that shows the state of individual 
> workqueues, so that dump only the state of freezable workqueues 
> at that time.
> 
> Signed-off-by: Jungseung Lee <js07.lee@samsung.com>

Applied to wq/for-6.4 w/ minor message adjustment.

Thanks.

-- 
tejun
