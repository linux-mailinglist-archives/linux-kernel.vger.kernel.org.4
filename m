Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279461F050
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiKGKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiKGKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:21:52 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC04A18E35
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:21:38 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id c9-20020a05640227c900b00463de74bc15so7933699ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihUiIO3ZLwpQKr6BgSjeEHYERb79BZdv2hX+HIlwkJI=;
        b=L5X++DuCad+8UxHidtzd0ia2QhWMBne6T5ULMfNTvrrMHUXXqX//6iwiE924aWtDl2
         LHjk8+PQvvWwiUAW4IM7/Jbaw9xPV3bB92LqE/4ckIEGVB9eU+8rjRaBGxYzVKh62B+3
         pffzH8ZFW3ICBI06YUAqiRNAyj/S9rF5NbVVXaC7T9sH/bXhSk9qFdYMgedpUpqAvXiL
         uOlBxfs1km20u40N9rIMzarYVjNpodlyESEmZHq/LZVkUhYHweZ5DLwmdEJc3n025kH6
         sBBYgobP0SiZSy/OJEJpKNxmdbVQ3Z+k3kee+L3N6Dx/f4OR8oKfE6aMdDBEnuoU2Rps
         i3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihUiIO3ZLwpQKr6BgSjeEHYERb79BZdv2hX+HIlwkJI=;
        b=A96Sz51cgfEvqtRc1Lgy2uiMWyheyDlFAcY07qfd7fLGBR0ryXJUPDOMuD+FC2S42w
         9ZpueakplPG5eK4R07iHcpDyXML9qniCREwVabFJ0LLeedVPslUlSQtNCrb4/KiooTL7
         /6QLbjNnW07bRHvJaM5HmDYl3MsEE0oslsf8kk7UwCMmU1rLxy861PgeUN/Iupcar0hv
         q2VdBhhhbTxjp7CzYVaF+V0l7gi+q5yw3qo3bHPVXg7WsYa20wZVQDbX+qx9ypNjQee4
         Y6gOeIOclep1SfmA7E+hUl8meuJ+g1XibHpOuqtKBJN2QErvKCMRpSuwRJ7/KOUGWaNd
         XrhQ==
X-Gm-Message-State: ACrzQf3DIWoZkqEM85cFv8zjsmMCrrSGuyGVnKSt7jr4Y8yAWZ4eYzU/
        cr0E1rCgxGwTGoyy1K3oRPRoJJtZYZ4Ubhii6g==
X-Google-Smtp-Source: AMsMyM4jq5TdocedxtCJg2krWmLr2HLqOAo0hc+LmOQKo7sUV/41w3aF32a0u2yLv+C9qrJe1WC8ojLmdAcUQOQh8Q==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:ce1e:a203:209a:548c])
 (user=peternewman job=sendgmr) by 2002:a17:907:788:b0:741:4d1a:595d with SMTP
 id xd8-20020a170907078800b007414d1a595dmr46434575ejb.737.1667816497306; Mon,
 07 Nov 2022 02:21:37 -0800 (PST)
Date:   Mon,  7 Nov 2022 11:21:34 +0100
In-Reply-To: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
Mime-Version: 1.0
References: <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107102134.255757-1-peternewman@google.com>
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write mbm_total_bytes_config
From:   Peter Newman <peternewman@google.com>
To:     babu.moger@amd.com
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com, bp@alien8.de,
        chang.seok.bae@intel.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, daniel.sneddon@linux.intel.com,
        dave.hansen@linux.intel.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jmattson@google.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peterz@infradead.org, quic_neeraju@quicinc.com,
        rdunlap@infradead.org, reinette.chatre@intel.com,
        sandipan.das@amd.com, songmuchun@bytedance.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On Fri, Nov 04, 2022 at 03:01:09PM -0500, Babu Moger wrote:
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared by the hardware. The
> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> +	 * every RMID on the next read to any event for every RMID.
> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> +	 * cleared while it is tracked by the hardware. Clear the
> +	 * mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);

Looking around, I can't find a reader for mbm_total anymore. It looks
like the last place it was used went away in James's recent change:

https://lore.kernel.org/all/20220902154829.30399-19-james.morse@arm.com

Are we supposed to be clearing arch_mbm_total now?

Thanks!
-Peter
