Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CE711A00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbjEYWKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjEYWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:10:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6781194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:10:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so239395b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685052630; x=1687644630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWofwYKm4U81VvMJrWpV6xYO9a00UoFB6BWy/cnrY+E=;
        b=NIoI+gbxG37mFRxdetHlxb+TND4JGIRaiEe2+QEuKFrINb6hrfK0YCf60PeSPIoaWO
         I0WFtbDzRao4SlCooprcVX0MR/iJocN8nZuYdZFLUigDied89IEkjO5jXSxcvv+KuZDr
         ZHpXgeonq7a7yDmC8K9kiv8U5PR27PGl4f0WToFjeIslUyeu2Y1Se5din16ii8ik8PY5
         ejluNX9y64CEqwP9qfX0ZF+3fxnyyp82aB+34liSB+VZ0/puwTl7meJH+7ze4T24fr/X
         D4pkZ5pd0hIotg6yUt+1Gsj5gm9VsMMG13fAem5ue8AVYAt73GRA5iYnnygDfagCKfAQ
         V0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685052630; x=1687644630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWofwYKm4U81VvMJrWpV6xYO9a00UoFB6BWy/cnrY+E=;
        b=WERdjGw/7WdDPkgcoeWSsf+oUl7871C2pobMcfzjsnqsVx7Oh9SD4eFjd2JIHYj29w
         7Ep2SnfDopevKuiYSbvK8e/h5q7QbP8GJg23TAuW0s0QcheGgHuL99duEKAL/+Qhgdgi
         3O0uXYO6NslyZ0MD0HS5LJ43IeW2zSa0/ojjHM+JxUBbowz9qi1hN/v5D8iABbu/7j0T
         w/qsGVXXnfXc9G6rEWlrA1AaY/J2SxT6wKhuESsGKnkwFC174pmiBToT7qDz8yHvwPR9
         6JS9Xtl3SRb1ZRqEzAc23Rp3ImkNtyMrQtu60rCyTx3YEwjj/0AAz21DQbyLe0jxlMGY
         AL3A==
X-Gm-Message-State: AC+VfDwL4J5Yc9qNlyY5FYU4EkNsTBIeOxQbihEEhfDCCl84KCzds18i
        E0EOTZ7BYIxNumO+Rdr6zuDjmoc9iXz1/A==
X-Google-Smtp-Source: ACHHUZ5Fueh+Lk77s0gKla6CGp/NJ6W4v5JX985lwO2Vn9KOfWlWO5tn1wZM76Ka+eDaDGz9n18pwg==
X-Received: by 2002:a17:903:1112:b0:1a6:74f6:fa92 with SMTP id n18-20020a170903111200b001a674f6fa92mr288936plh.19.1685052629979;
        Thu, 25 May 2023 15:10:29 -0700 (PDT)
Received: from localhost ([2600:380:b551:e8fe:da52:61ec:2b97:ae7f])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b001ae626d051bsm1879811plh.70.2023.05.25.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:10:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 May 2023 12:10:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Subject: Re: [PATCH 03/13] dm integrity: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZG_c0xGh9xbXOFSt@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-4-tj@kernel.org>
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

On Mon, May 08, 2023 at 03:50:22PM -1000, Tejun Heo wrote:
...
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: dm-devel@redhat.com
> Cc: linux-kernel@vger.kernel.org

Hey, I'm going to apply this to wq/for-6.5-cleanup-ordered. As it's an
identity conversion, it shouldn't break anything. Please holler if you have
any concerns.

Thanks.

-- 
tejun
