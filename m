Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADA728B51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjFHWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjFHWwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:52:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9A72D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:52:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b24b34b59fso2199255ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686264765; x=1688856765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFqySKofLrUaTpKI+X60pD5eBar6zemdxEU9aJdNk8U=;
        b=OqIaaVy7z3fGTHaaBp2Obrjt7BLjq1bYqMgSFrG7ndQVgAZy8OsOuEnpZKEsHWrle2
         LApMd9vZ+04KuCZrCerG4h0LkbtUrxO40ex/vphsPyutaIvT+l8HeB0tdctaKeWyBHbn
         dOnV16pz3UNlgy1eQ5/EzPCnEgUHn0guel2unaK6hOPhdQ6SENiKk5K0Q9A6WrhZ2hPy
         JFyfxFCFmaF9DRrp/ktS/cEtg7p8xhPMiJoSpJxCIzQ6ZN2glgFyrKLzEx7kuAWNKixA
         VomfonlYmbb0zZ1OM2s1z0yxiuHwcIQZF7Q1Ro0AdNpyXBDSH8MM2dJ40WALD6XY7ePk
         yslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264765; x=1688856765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFqySKofLrUaTpKI+X60pD5eBar6zemdxEU9aJdNk8U=;
        b=MCOD3/9HOKxuJRhvxyMyAQCuYJeOk8ktYFocQ2vvPuj/WkJp+7Z0ZEUMRpi7O6ZFjm
         QUNrVVSYMGyi2WsaLOMUfugu2pihzvy+70cRoWKr5MVChhXa44xUfTwviW0JeKYhiFCr
         kegAz5NGT5WN1PG8h7laHmXZ4Jgizvd0KoiSX1d3KDBWIOgl/30fl7XFRl5OOaz7v4aC
         fMme+wK2emo5/FBKzk6PGb+y4uqWoMkf7fdlXYCquy4arVGaCg37RdRt2MgIWo6r1Orc
         2MdqA9uOLH87GAVXjAEF+m1zGl3pHzzJISypzlPg3rVQyVaeHGVEeyXWvVyrV5iWPllr
         BmvA==
X-Gm-Message-State: AC+VfDwcrE4Ig7t3LgvJrIgqjtckUtEYoohyrCI+w8pe4HT0X/1F3/lH
        asn+6xKPy/R46nAgz2eapUs=
X-Google-Smtp-Source: ACHHUZ5AaO4gyJjsZuqBqQaE7cH17xRSjxYV5oSHB/GVHG3d2z1XjB/syLt3MSN78M6/vXAs3v8kIQ==
X-Received: by 2002:a17:902:ea05:b0:1b1:9e18:d409 with SMTP id s5-20020a170902ea0500b001b19e18d409mr11257522plg.39.1686264764481;
        Thu, 08 Jun 2023 15:52:44 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0019aeddce6casm1889238plf.205.2023.06.08.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:52:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 12:52:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net,
        zwp10758@gmail.com
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
Message-ID: <ZIJbvCcaqjzNteWs@slm.duckdns.org>
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
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

On Tue, Jun 06, 2023 at 05:31:35PM +0800, Tio Zhang wrote:
> Introduce queue_work_cpumask to queue work on a "random" CPU onto a given
> cpumask. It would be helpful when devices/modules want to assign works on
> different cpusets but do not want to maintain extra workqueues, since they
> have to alloc different workqueues and set different
> workqueue_attrs->cpumask in the past times.
> 
> For now only available for unbound workqueues, We will try to further
> patch it.
> And default to the first CPU that is in the intersection of the cpumask
> given and the online cpumask.
> The only exception is if the CPU is local in the cpuset we will just use
> the current CPU.
> 
> The implementation and comments are referenced from
> 'commit 8204e0c1113d ("workqueue: Provide queue_work_node to queue work
> near a given NUMA node")'

Can you elaborate the intended use cases?

Thanks.

-- 
tejun
