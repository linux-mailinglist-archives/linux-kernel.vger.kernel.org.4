Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C7667ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjALQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjALQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:25:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56F11C01
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:22:51 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 36so13104934pgp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vB0w5hjdsWCfkQP5Y95AvOXTkdHE2CROlFTANzMo4CU=;
        b=IubnWWfLUPHA3oUNtQ+sfKJVWy0CK4iZTWemA0Nr5fVngU5zirmKebWcctwT1vaRon
         xSt7rsTSfZQSe9fu3jJnbGFVnPnw2Sm1nZoRZxbqciSdF+l5l/fBmUyEeOpB1w3gqdz/
         9YpSrFfDdaBCc59K9XR5bFCB8p9lp2je2g1Sr8MkkS1Am4E8io7goZZuxXX+OB4yf4QR
         03LTkMtZmbasn7XhxB7OaoFCqjP8Ng9XjUM79ftZ2TR6kGPPOt9JAIridPsU+PuPrtrl
         f0WnofG/guWyPJcpR1pAUjsUUu+omdq6k6CWcPsn/Eluev8XXVQjYuiTT+8EYeViT+uK
         AuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB0w5hjdsWCfkQP5Y95AvOXTkdHE2CROlFTANzMo4CU=;
        b=h29l3SGZLh0Jra4Ora8G+zt7+DF74X5g1HHKZ+SDvBtgtWYyKao897BLkMXTI7sShX
         sPIwOUSSTjKdA8osk+Cn5KHTf3qIResu8C6XxyOoW9RZk1cAixhY5uI161Rs4sEFBnaq
         2cZmW33tUiMQaYECu3VLq7KuSBlroIaeUBdt8HrK8Vdhee5tckbMXXo+25X1a/zFAwNP
         XKdRSV70P1FwGLNjDyHB+EAGQlKZLINnqhW6+tjTcWJvnDVOR9E7MU1hjGFkSUWFKXJR
         cOd7exAM6R2UvZv8ZWttAhO5pT9bbszfkfv1y7qpwdz5g08yl6JNO5X5lDayY6S9vlaj
         2mLg==
X-Gm-Message-State: AFqh2kr4iFDgkgNbkuhZQf+VMqCAGhYQwB+kRcob7GuRL4spTOD84lRP
        AMiTuplqpcRDlgmrM0qqL/M=
X-Google-Smtp-Source: AMrXdXuxHaeUPXuzJN+HcbSlKFn2gUdVfkBO4uQDG30PwEv0IDHLU2Zmgl5cZ/9ert2uApUSSfoMaQ==
X-Received: by 2002:aa7:8f09:0:b0:587:364f:17f5 with SMTP id x9-20020aa78f09000000b00587364f17f5mr6668516pfr.7.1673540571185;
        Thu, 12 Jan 2023 08:22:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b005821db4fd84sm12063047pfk.131.2023.01.12.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:22:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Jan 2023 06:22:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v8 0/5] workqueue: destroy_worker() vs isolated CPUs
Message-ID: <Y8Az2cn76ayuGCdV@slm.duckdns.org>
References: <20230112161431.860196-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112161431.860196-1-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.3. Thanks.

-- 
tejun
