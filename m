Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13A65DDC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjADUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjADUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:42:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B11BE81
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:42:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so35708202pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N16dggiax6f6dzK8eCkSrnJql3tmNTxLuxA779iCwTU=;
        b=p+sW4wLNZYgB10KM8ONYPATYjNfxZ7l0QAAbrMbKoU0D1q4KDg1D+qL/WXxcy2Z7gb
         pHDQDaiMhyPJyGa9Ioo7rClJNXHqdgCnYxE0YImftxXRliNtyJxR1dbwBUHrvk7aJwZF
         khA1wWSMpnG+Cv3lO9MUXdnqIgm1q3mOnSfeyYAFQPzH6vkojCnEvml21itLhuciQtuC
         phDez8YQMhV1swO92gE9UcCFDtVw67pjGw/LsN3fbLynFHm7JIDIQ8LEOWMd9CAytyLc
         IL1+hgPfULIgNSbzNI4ut1y+wvLckQf5JaAldAZdO2CdeTdqX/PZEn04Qpf8/VuFnvis
         19Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N16dggiax6f6dzK8eCkSrnJql3tmNTxLuxA779iCwTU=;
        b=rDFOjhHdiq50k/Ly1H0UlI9iH+zM2s/vyqLpHCcHkKbXDkvsx3rGEB2qCCcFxBgkG8
         +6QM7+cG5mwFqt1DaONwl7ybUaVlXK34NaAX8U0bSvC9AoYTSLs0z3qTB0+EtnaV3PRN
         tkdQGQTXoQ6SZoB6YgSycPXWm4S2XyZMR7UWCWT9ypUbcZ8NC7RfyjmMewQP4mAkU9mn
         9rOpdBMLaZbKWu2c4ZhZ1aQ3ljTEize+/weuok4ad+IWRR3T5EvtbjtV+P1mqpz6ktby
         oz8+vG0UGJYkPNsMwWUP1EZK+QVooq+6BMYEtGtR2NsBvpqWRneb9klzVqDfNXt/zHXP
         aQug==
X-Gm-Message-State: AFqh2kopWGJ4Pd664UauFYvNs2aLtQTc19/UY+9iMPO71xID+IA6pR+4
        Iu23SEiqRQHBr2qAfgtVWN8=
X-Google-Smtp-Source: AMrXdXtqD3bFkmmEtBfvPkewGH1I8nuLisFKU65QeGyKhWXyqRvixYlIdZ90zlGyIpwpimjeZBsB4Q==
X-Received: by 2002:a17:902:ce02:b0:18f:a5b6:54f9 with SMTP id k2-20020a170902ce0200b0018fa5b654f9mr54261178plg.11.1672864931910;
        Wed, 04 Jan 2023 12:42:11 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b00192849d1209sm5201665plk.96.2023.01.04.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:42:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 10:42:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kthread_worker: Check all delayed works when destroy
 kthread worker
Message-ID: <Y7Xkob/rqarLKf7p@slm.duckdns.org>
References: <20230104144230.938521-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104144230.938521-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 10:42:30PM +0800, Zqiang wrote:
> This commit add a check for delayed works, when destroy kthread worker
> if there are still some pending delayed works will trigger warnning,
> this remind caller should clear all pending delayed works before destroy
> kthread worker.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Andrew, can you please pick up this one? If you'd prefer it to be routed
through the workqueue tree, please let me know.

Thanks.

-- 
tejun
