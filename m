Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF775600B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJQJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiJQJl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2A1741B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665999714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMuU+pqi1h2+EeSPvgKCOH71WbN83gyARiDrRWADRbc=;
        b=PW/IbfnYzrFnEXiVbE8w2j/OLh4AiCEvQ0SWHoM/WN1zwGTcoTxfZ4Aqc3kwaPOZ02LDfb
        bBKeYOCz8P8BSIZy2vR0WUoycDBspVmDMhRzvWsCbBUnhdCMSXY9qS416NqjLULDfe1ptX
        C2EWoBtZzyz7NZ4P88c4X66ire1PEvA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-roiJKX--Mdmtdg49fS6IPA-1; Mon, 17 Oct 2022 05:41:53 -0400
X-MC-Unique: roiJKX--Mdmtdg49fS6IPA-1
Received: by mail-qt1-f198.google.com with SMTP id 17-20020ac85711000000b0039ccd4c9a37so8025363qtw.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMuU+pqi1h2+EeSPvgKCOH71WbN83gyARiDrRWADRbc=;
        b=fh7u+cTsXFbq2fsE0Tej5vnMYOjJzPM8Rrr8LJW6C1yGfGZYLaiN2xMMIkkWxlXNBX
         MTlWi+2zPTAqEHnHzsA+OHHgg3UTWwfaXkSpeH26Z8w6MvA0qY5CdzxBeqzldeDoWSvq
         Gax5HifdIPdmeopyHM7yIcTSEgeIqUSpD5TNbFQZOfhmRyaTofVC21bSzsMhWtbUoUbp
         LLZ+1wpbQ8jjdJW0uMA91K7/eMJQGRR2+dUi5xMH/J/jZ6GxfpmDKVs8JDCyLBcUp3xH
         +7lfxgEXxCSyEkYC5y+d4l2cRPT4WvOzJoXQAkJ+1Cy3IczBhuYkiiyBSjUbhO0P+Ip+
         NSQg==
X-Gm-Message-State: ACrzQf2TY9KrU4UIc3I9ZKEPVNHlhEq9ZTQNKYTrWDo8ml8N++kE1WcF
        BDa+wPA3WDE/8kF0DG9UW681F+ErklO+cSLPnTjlo8yXV1MM02Uz9ks/yjKG4yriXRVNv+9iXNh
        4BlRJMMBrDzQkxB+FOPhf1KdM
X-Received: by 2002:a05:620a:2453:b0:6ee:d4bb:e5a1 with SMTP id h19-20020a05620a245300b006eed4bbe5a1mr7023662qkn.332.1665999712792;
        Mon, 17 Oct 2022 02:41:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6yQogelr3NDRx5zUsJGFGhMHTU5mhuhDy9uTrP6szhkztl2hSNY4B2MY7nP7Qe/F56K71gvQ==
X-Received: by 2002:a05:620a:2453:b0:6ee:d4bb:e5a1 with SMTP id h19-20020a05620a245300b006eed4bbe5a1mr7023657qkn.332.1665999712607;
        Mon, 17 Oct 2022 02:41:52 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id 66-20020a370745000000b006cfc1d827cbsm8708855qkh.9.2022.10.17.02.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:41:52 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Add __cpumask to denote a trace event field
 that is a cpumask_t
In-Reply-To: <20221015071416.00369347@rorschach.local.home>
References: <20221014080456.1d32b989@rorschach.local.home>
 <xhsmh8rlixqvu.mognet@vschneid.remote.csb>
 <20221015071416.00369347@rorschach.local.home>
Date:   Mon, 17 Oct 2022 10:41:50 +0100
Message-ID: <xhsmh35bmyeg1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/22 07:14, Steven Rostedt wrote:
> On Fri, 14 Oct 2022 18:21:41 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>> 
>> Lastly, given all cpumasks have a (usable) size of nr_cpumask_bits, we can
>> factor out the size argument, see below. Regardless:
>
> Seems reasonable. I can fold that into my patch and if you reply back
> with your signed-off-by tag, I'll include you as co-author.
>

Bah, you did all the work, but if you feel like it:

Signed-off-by: Valentin Schneider <vschneid@redhat.com>

