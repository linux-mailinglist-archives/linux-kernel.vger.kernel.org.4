Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27927619A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKDOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiKDOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:40:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39399252;
        Fri,  4 Nov 2022 07:39:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt23so13784914ejc.7;
        Fri, 04 Nov 2022 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TKI2Rm0nmAOBvoxMHybRVhHgXn9iOorCatBXZqOgdZQ=;
        b=KyeWtzWN1f6d/r8FPUC2Hejyin0NjpcVdthIye+ByVrThaas4/ycSeE4Dl2r/v9o/L
         tJApK9jqpu7Jq73ium4P/LULmFioy4gHnWcpyp/Lo+3eMc9t9p+CQGh9uR4vHFk6QPKP
         dLy58PY4huuLSWpfTj/5vKA5tS89PnsrfUSxWVji4Tba+eSX/dHA2/IH4neQf5AnHZ8p
         ts7WAVqQf2kvaTfYt/0lSvIUbBOXjb8lyf5U5IbAG6Wb9gT2H4+m/CjunDGXNJ4IkgWQ
         0w0ZwNYlIJ9TN2nB4gcTIzmwd/FhCIU2b6253Z1mQdWzEICOLL2Z+pZXy3B2mE6etZ/E
         NUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKI2Rm0nmAOBvoxMHybRVhHgXn9iOorCatBXZqOgdZQ=;
        b=zaExL5eG4AXeXfdS2hZCtc9MkkAEE4bDJRBxFvckvpCfDvqxHy+wgDmqXmHC7l+OPu
         g92LMfA0GGssbTR2ey7P4DB+JJUzXTNhdQc3mAAhnu2v0wPziU8U9H2brAptjK0G1vfz
         HwDkWeXihL/dlLDfyCDHPJptgMX5LPwOfQu0iyiG3r2KECn9P51hV95MvFrPvQvxn+dt
         SBDAKXDACC6ohV+eWqC8T/BZoU9fo3TGXRAZEJTqHq/PbONRzZY6vlj1aDo/VZcp9BUa
         pbg0EL8dEyFhz+c/9RrS2ZgdyxjTu5JllFlvLgjukNm/TK53tqTYqaeDgyKiHOjX8ixd
         XZyQ==
X-Gm-Message-State: ACrzQf3JHN3eijOQ2xhoHYnKkET70cnDcTfItyzvIok2lXgQoBSwTG5M
        V87wrDCap/++ZwWNk036A2o=
X-Google-Smtp-Source: AMsMyM4PLmGit3FGL9qRVhbCnGUWxyNsqyUD7mQyrD2IFqsNFrbdPvR41NcNJevkiyrOrugAGNWrYA==
X-Received: by 2002:a17:906:8473:b0:77b:efa8:50e4 with SMTP id hx19-20020a170906847300b0077befa850e4mr34569102ejc.250.1667572751642;
        Fri, 04 Nov 2022 07:39:11 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id x67-20020a50bac9000000b00457b5ba968csm2001658ede.27.2022.11.04.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:39:11 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 4 Nov 2022 15:39:09 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2UkDZDKXOaH9jA0@pc638.lan>
References: <ACF5E134-0C17-484B-AF9E-D4E6FAC9535F@joelfernandes.org>
 <B78EFE6F-D479-4F96-89CC-E19CA4146FF8@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B78EFE6F-D479-4F96-89CC-E19CA4146FF8@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 
> >> Or am I missing something here?
> > 
> > Yeah I am with Paul on this, NAK on “blocking in kworker” instead of “checking for grace period + queuing either regular work or RCU work”. Note that blocking also adds a pointless and fully avoidable scheduler round trip.
> 
> As a side note, it’s notable how nicely this work evolved over the years thanks to Vlad and all of y’all’s work. For instance, flooding pages with kfree pointers and grace period polling was not something even invented back when kfree_rcu was a simple wrapper. Now it soon will be actually freeing memory faster, by avoiding waiting on RCU when not needed! And of course this is all happening probably because we wanted RCU to be lazy in nocb is a nice side effect of that effort ;-)
> 
Yep. We want sometimes everything to be lazy :)

--
Uladzislau Rezki
