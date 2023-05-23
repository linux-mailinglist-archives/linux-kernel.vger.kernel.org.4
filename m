Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6224970CFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjEWBBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjEWBAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:00:44 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACC196;
        Mon, 22 May 2023 17:58:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-534696e4e0aso3863748a12.0;
        Mon, 22 May 2023 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684803514; x=1687395514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/TN5H2z3LpXN/tgkrSVUCXuSpR0rK3XhYwk0PjuaCI=;
        b=SIwN3J9dLeEEUFNtNtwBysRaT7B//5MeVsP8eyBLenB9tLtdAzIMNcTrapemETi0lu
         f1Cl5tIL63VPLJx5Q4LKuB75//+F2jh8mbJ1zUsBqcsOwmUTvolshbVb+UArw5bCYJtY
         nR1UAg5TqImG47wr6VeaWs+oPgbunaMFFcpx8C/tHeyQ/jMkpa1LLA81tlUTjMNy6v2/
         1bOMr1PAY2Xg/TarKOHVxPAf+Z2BhYkonq/Nr8yStZ8kZqgFN9B1CoCX5shd0QpEz5ee
         UrceODeCBkUTnIcd7TCgqTiKbZatsGgAWuIqz2+pdr8856jkJI9JgitwY0ks2V4JS5C0
         JAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684803514; x=1687395514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/TN5H2z3LpXN/tgkrSVUCXuSpR0rK3XhYwk0PjuaCI=;
        b=Yzx57jCBkXQV8S8HGN/lKMLGWqhGyEX8IsxuZvjAuS1JRuOlCOlJiCz0K6ekwA2o1A
         q25gtVnHlNyL/2bV6ua+E7EF1/4LHm3uXkxpSS9jN/Vmsyl3YhMI9zOFL7gcq0JaGgxI
         X0cVGNoM6RfRjT4kM3pwB1mpZQS7mO/xhXl56UsAY1UhYjFeX5kycaBtslCf6HSYEBY3
         9Vr31tx3KNg9w7jtToyNxunXjbwTFQdORn9/wgTPZCJIiAYqojRvtbAH4syttrgxnY/k
         ZuT5c15PaanB8hEW0X01/eD75s+fsViRpXEAvuZHDaF+Ef+m7En1ILJKf9zCNjmdO5Xh
         AlAg==
X-Gm-Message-State: AC+VfDwvJXIBeqUI00hfgsQr8m42Mu75/37kQp0hPIg+VAEowBZ/7qSv
        2wv4gnO7KyEYUgBJsf+Yq5o=
X-Google-Smtp-Source: ACHHUZ5pW0WgPZKvATk/xZ1Socp7ec7BFUpiko1vlkAvxBEG7EBNK6x9a9f/nA9U72TmTSC+B7koQQ==
X-Received: by 2002:a17:902:c153:b0:1ac:988e:2624 with SMTP id 19-20020a170902c15300b001ac988e2624mr13628616plj.37.1684803513520;
        Mon, 22 May 2023 17:58:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id i1-20020a635401000000b0051b36aee4f6sm4914044pgb.83.2023.05.22.17.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:58:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 14:58:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH RESEND 01/13] scsi: ncr53c8xx: Use default @max_active
 for hostdata->work_q
Message-ID: <ZGwPt4VNs1RhWpvn@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-2-tj@kernel.org>
 <ZGmGZxYmN0En7wAB@slm.duckdns.org>
 <yq1v8gkm3aq.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v8gkm3aq.fsf@ca-mkp.ca.oracle.com>
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

On Mon, May 22, 2023 at 06:06:56PM -0400, Martin K. Petersen wrote:
> 
> Hi Tejun!
> 
> > Subject: scsi: ncr53c8xx: Use default @max_active for hostdata->work_q
> >
> > hostdata->work_q only hosts a single work item, hostdata->main_task, and
> > thus doesn't need explicit concurrency limit. Let's use the default
> > @max_active. This doesn't cost anything and clearly expresses that
> > @max_active doesn't matter.
> 
> > It's not a must but it'd be great if I can route this through the workqueue
> > tree so that it can go together with other related and followup cleanups.
> 
> As Finn pointed out, please make sure it's tagged NCR5380: instead of
> ncr53c8xx:. Otherwise OK.
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Will update and apply to wq/for-6.5-cleanup-ordered.

Thank you.

-- 
tejun
