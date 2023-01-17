Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DEE66E291
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjAQPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjAQPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:44:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7A4996B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:42:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9so33903592pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raIP5zSqF/STW+kTCBVQJ+PuTh0fIF3QkrpzqbxnVwM=;
        b=Fboqqh9dagbWo2L8wq1Lo26iSaSU57WhxjC/fOz7ecCUNGGEDVLeXoK5K/pHZwcsFV
         N9jlLxyCR6qNXQQ4U7mpMErHB3ZrEWyqQtK2JQndhA0MmCFiGJ+4PPhTRD0Wix0EL65j
         MsYHUDHxtRNkvOQ0WUDga80seOuHKWPkpKj+FGWEAdrMpGI0dVnRWM5khsCPm4X7lwaH
         x+1LaU365neNHCMM/NnCQEGLIUB0p9uhI/3oVwVMGYmas44XJFXRd2YVZkXp0yoqHUtJ
         ciWpysAmyUCCthwpSIl7KFTDHsYIFtORoQMrRwss/5rncAUrPaGaZx9iAg7bu43XjA0x
         fYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raIP5zSqF/STW+kTCBVQJ+PuTh0fIF3QkrpzqbxnVwM=;
        b=s9hur4Qcp13fQCXq1WAdRnRJorIfNpuz/GhUKmT3VRzYapAQ2X8ZAGhTFcXU6jB2SO
         xUyuOox7YT30ZKNVgxVkWiOusuRrVyo6yIzZp499zGeFZOhPBsqtrs84vv3dqo3lhkNG
         TIsWIigEy51fZzU/b1Aw1p6+3Xo6pd0KkR7UgMMQJs/nv89BrKyOnUY4lrJiOf8qHclS
         ksmD0YRwwV7ouonb0T2duzqGz2wrvAm4p7qJVoNp775cbj6mP4//ZLz6eUvaXrMoPtc6
         GqVmZY38LZzrxpNR0h2X+XjFrTCU4reWakzSwH/Cw9lzG7EJTF5z+ttxcm2TGexJLFEA
         RVaw==
X-Gm-Message-State: AFqh2koR+M6G7omS4ibSAMu91ZZ0onCNB97HYXsRdRNY/VpADhKk+rGq
        CKpdu+sLX9wjBeMGNjvQNNOdMQ==
X-Google-Smtp-Source: AMrXdXtc4FtedAeo9e0ZaQ0CoHayTm55NeSTXxytLBxVQsTrdtckjUUE0ev7gjaj6X6vcVC1fBOKfQ==
X-Received: by 2002:a05:6a20:a883:b0:a4:efde:2ed8 with SMTP id ca3-20020a056a20a88300b000a4efde2ed8mr2357042pzb.0.1673970128358;
        Tue, 17 Jan 2023 07:42:08 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a348a00b00218d894fac3sm20692438pjb.3.2023.01.17.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:42:07 -0800 (PST)
Date:   Tue, 17 Jan 2023 15:42:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, maz@kernel.org, corbet@lwn.net,
        james.morse@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, ricarkol@google.com,
        eric.auger@redhat.com, yuzhe@nfschina.com, renzhengeek@gmail.com,
        ardb@kernel.org, peterx@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 4/4] KVM: Improve warning report in
 mark_page_dirty_in_slot()
Message-ID: <Y8bBzKF17IdZP9eF@google.com>
References: <20230116040405.260935-1-gshan@redhat.com>
 <20230116040405.260935-5-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116040405.260935-5-gshan@redhat.com>
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

On Mon, Jan 16, 2023, Gavin Shan wrote:
> There are two warning reports about the dirty ring in the function.
> We have the wrong assumption that the dirty ring is always enabled when
> CONFIG_HAVE_KVM_DIRTY_RING is selected.

No, it's not a wrong assumption, becuase it's not an assumption.  The intent is
to warn irrespective of dirty ring/log enabling.  The orignal code actually warned
irrespective of dirty ring support[1], again intentionally.  The
CONFIG_HAVE_KVM_DIRTY_RING check was added because s390 can mark pages dirty from
an worker thread[2] and s390 has no plans to support the dirty ring.

The reason for warning even if dirty ring isn't enabled is so that bots can catch
potential KVM bugs without having to set up a dirty ring or enable dirty logging.

[1] 2efd61a608b0 ("KVM: Warn if mark_page_dirty() is called without an active vCPU")
[2] e09fccb5435d ("KVM: avoid warning on s390 in mark_page_dirty")
