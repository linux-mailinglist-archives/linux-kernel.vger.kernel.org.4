Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF085FB6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJKPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiJKPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:23:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1E3FD69
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:14:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i6so8418515pli.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6thVOnVSGwn0DWU8H035BDk+3ZkV4dynQnSEU4XWXY=;
        b=VMgLZQ00fqPBYuQhHmEPGedkG2gjsKWPpr+T6OqCgROuL3e7nfu0DidXSl3tney6iS
         sy3TFMFm3qk880mQ/CKAdrZ59+QOled0Tuo1EHhAhoN4hX1ZCy0SZs/KH8Hf8NXPRTKp
         p5jWkJkB3RmRAQFhNSQw0trxXpFwCAoMsybdWcXH12qicOUbZlz2eFaAP4qhwYeWRYal
         xl1rjePLRjfYcWYv+danxh9h0lOTjW46rPz+N/o6XLNhykt+Or/YclL0bzNPhoy24XvE
         tbSI4TgkAHpwcDMkRVdPuDOujwouewy/79yg2UIE8AjVsd/RGDBGeRRDa0Gs/DHrXR1B
         LeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6thVOnVSGwn0DWU8H035BDk+3ZkV4dynQnSEU4XWXY=;
        b=eMGF/eSIxi6MWZnJx5rcFoKdKIMbivdn9FVrOnioIh+0aMqLPBTX4VkJ/c8siXl7Q6
         kD6UZTJ+AIFCBlnY77XJCIR92xgkzcCHHNL7GEtqducuvKqZxCUssPtCu8tx2uzlQ01R
         Dt98CGAhNG/zKsm7HdbsuVEgjPqukBSUpLtRdiRZ/xf560PtPgs/2TBpLLshii0Poriz
         tBUVMZ19AUUseHhIo8v8rHpkuCD11svxA0ftSVyJLIk9CEjbioSBkikP+NsWh5lFnO8g
         zgOIssU6u73UDlxNGV6nhk9o2GFPN9xX+4MDifXHn9vi9qWGaPzkBWy6iCxZMTl7Zffz
         vSvg==
X-Gm-Message-State: ACrzQf183dn0dDmCqmTiFUwOu0xew98OM5PRAGk1sKtMR17dj350ZNSM
        C4NNZq2HAK+RZpdLoviSDh+D0F6Z5IgnfZjRUZRpvOivv98=
X-Google-Smtp-Source: AMsMyM4TOTZ2/+rxTMQrCYqWT7v6PkG6tatxR1Yyf55utLI093XgLfCdEiW2OWQST867U87EdcLb5pWWIVVCElzkSfk=
X-Received: by 2002:a1f:2bcd:0:b0:3a9:a435:2880 with SMTP id
 r196-20020a1f2bcd000000b003a9a4352880mr11818984vkr.17.1665500390360; Tue, 11
 Oct 2022 07:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
In-Reply-To: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 11 Oct 2022 07:59:39 -0700
Message-ID: <CABPqkBQcXbTg78yPkQSUpLHxXwZERpN77PzKh=fHZiQx0cmd1A@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Peter Newman <peternewman@google.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 7, 2022 at 3:39 AM Peter Newman <peternewman@google.com> wrote:
>
> Hi Reinette, Fenghua,
>
> I'd like to talk about the tasks file interface in CTRL_MON and MON
> groups.
>
> For some background, we are using the memory-bandwidth monitoring and
> allocation features of resctrl to maintain QoS on external memory
> bandwidth for latency-sensitive containers to help enable batch
> containers to use up leftover CPU/memory resources on a machine.  We
> also monitor the external memory bandwidth usage of all hosted
> containers to identify ones which are misusing their latency-sensitive
> CoS assignment and downgrade them to the batch CoS.
>
> The trouble is, container manager developers working with the tasks
> interface have complained that it's not usable for them because it takes
> many (or an unbounded number of) passes to move all tasks from a
> container over, as the list is always changing.
>
> Our solution for them is to remove the need for moving tasks between
> CTRL_MON groups. Because we are mainly using MB throttling to implement
> QoS, we only need two classes of service. Therefore we've modified
> resctrl to reuse existing CLOSIDs for CTRL_MON groups with identical
> configurations, allowing us to create a CTRL_MON group for every
> container. Instead of moving the tasks over, we only need to update
> their CTRL_MON group's schemata. Another benefit for us is that we do
> not need to also move all of the tasks over to a new monitoring group in
> the batch CTRL_MON group, and the usage counts remain intact.
>
> The CLOSID management rules would roughly be:
>
>  1. If an update would cause a CTRL_MON group's config to match that of
>     an existing group, the CTRL_MON group's CLOSID should change to that
>     of the existing group, where the definition of "match" is: all
>     control values match in all domains for all resources, as well as
>     the cpu masks matching.
>
>  2. If an update to a CTRL_MON group sharing a CLOSID with another group
>     causes that group to no longer match any others, a new CLOSID must
>     be allocated.
>
>  3. An update to a CTRL_MON group using a non-shared CLOSID which
>     continues to not match any others follows the current resctrl
>     behavior.
>
Another important aspect of this change is that unlike the default
model of moving all the threads to the
control group corresponding to the restriction, it allows each
container group (cgroup) to have its own
resctrl group and therefore its own RMID, and therefore its own
monitoring capabilities. This is important
when we need to track who is responsible for bandwidth consumption,
for instance.

>
> Before I prepare any patches for review, I'm interested in any comments
> or suggestions on the use case and solution.
>
> Are there simpler strategies for reassigning a running container's tasks
> to a different CTRL_MON group that we should be considering first?
>
> Any concerns about the CLOSID-reusing behavior? The hope is existing
> users who aren't creating identically-configured CTRL_MON groups would
> be minimally impacted. Would it help if the proposed behavior were
> opt-in at mount-time?
>
> Thanks!
> -Peter
