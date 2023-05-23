Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F870D175
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjEWClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjEWClR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:41:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE9CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:41:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d426e63baso3783199b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684809676; x=1687401676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwvpwVxtF6IMtlvqhueSz34lEXXjDUBtDVPr+ojaxvw=;
        b=felV7hbd+ikFWUKwfJ5VzT38dKW2UXWH7WaC9TARuIDw79cmTmbndUO4frD8gYZSSN
         DKjpxk9W4pYfnJmsbiZLEJjfxuu6rwPjjtRegShY6rnxf3Cqlhn6e34dwJoKoTMijjZI
         b05Ce+xMb0KWJV/79iiGWLbH1uLh4Xy00HWIIY0DLvK5lpQrJCLIpzl1yZpGs7TZ9K6q
         bEyXxbM4wOMgJX90chbCq/EnPGRZ6IJQd+ZpSO2Mi7nW0qOrNHdbXx2QbN6l3D7MFzU9
         IFlT8rvGS6CdNvns6a3uNP9CSxYd+/XQuKgPSGyCa316S4RRKq2uZJdmc49KZDNwUi87
         yc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684809676; x=1687401676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwvpwVxtF6IMtlvqhueSz34lEXXjDUBtDVPr+ojaxvw=;
        b=MhMHAYGm2743Ty3tB/pZeAm06b+dnskJHrUetAWPsRRurRb0CveYb5fy0s3YNemd8w
         RroZQf4iNu4XBZwu/R7KByEX+gfbYKwamaEqu8COnrq9xn/oicQHK6V/RvDFnsA/Pb8J
         LJhpcnEN4bHXmR7gp2NovYQEAPwEOmynkkTjlaaYYYx0XtfRDOJ37hWsrOEO3CkDEkFP
         IisMhCsJ8oHeFW4/rzpsU2MTfsKe7H9HvT4Dk3e38htYJRbzLD5k00mYR6MHwUVACIdP
         OKoiWa2xPQDcg/ItYzeuJPNaLRFOpJ+dHbzSYdRdX+H+zHvz78RGNdQX6IqrOXvagFhP
         a9KQ==
X-Gm-Message-State: AC+VfDwSsBae3PqhfpKDa7oVZUniGsY3W8YGh03cyD4rqnPGi1uaNyfb
        +Sg12CfQV+/EewPkQewC9sY=
X-Google-Smtp-Source: ACHHUZ5yn5Pu5ypoACwjm0dHl62woxNMK+n2v3wX0I+bBbEnveBtaO9C8wha9fLUfr/yy+WauAoqtA==
X-Received: by 2002:a05:6a00:1486:b0:641:3bf8:6514 with SMTP id v6-20020a056a00148600b006413bf86514mr18087979pfu.10.1684809676152;
        Mon, 22 May 2023 19:41:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b0063b7c42a070sm4734986pfn.68.2023.05.22.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:41:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 16:41:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev
Subject: Re: [PATCH v2] kernfs: fix missing kernfs_idr_lock to remove an ID
 from the IDR
Message-ID: <ZGwnyoCI7kTxgEs6@slm.duckdns.org>
References: <20230523024017.24851-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523024017.24851-1-songmuchun@bytedance.com>
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

On Tue, May 23, 2023 at 10:40:17AM +0800, Muchun Song wrote:
> The root->ino_idr is supposed to be protected by kernfs_idr_lock, fix
> it.
> 
> Fixes: 488dee96bb62 ("kernfs: allow creating kernfs objects with arbitrary uid/gid")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
