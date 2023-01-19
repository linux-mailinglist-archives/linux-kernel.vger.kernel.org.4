Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2756746CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjASXBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:00:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40149A2950
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:51:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k13so3789135plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIv9F0F9kZjWULEqGed71L3vGLsXGCblsRQVgkNfMGw=;
        b=He8MjT2hj/KT1Te8jXq1GdY/IX7LuFGXHEeDJq1PPtZCie9SaZo6cMbRQxP4pE7WGf
         61IjuawnrfjpY6X/K8OVIIp6IgmSBPUu9P9JwX3NBZsMYZSWWk1J/rxXVuUa/luF50WP
         k8GPCO12bOv/MToVcdP4zOt7Uho/ykno/6wdfz1x2/1PH38Z/bj71fC+qALBl31ZOwAG
         NQgNUvdLwYkOyN751v+jLxOauYwYm5CWel4Mk8aLWXJV6Y/Mu71+nQWS4I1J01D8y8Sh
         N1a+AC2CzAjayKOxXlsGTrcoFYXbihdTKqgqIBoW6XRtXR0V0dQ6sfnoqF0AmBQTf2nC
         jIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIv9F0F9kZjWULEqGed71L3vGLsXGCblsRQVgkNfMGw=;
        b=XEnYSNuCpINyUQg8LZE9IAnj98R3x4n+mapFXG02NcalkQqZFPkLczSF2B4ROXjx0l
         ipukGdzMSM0pKlnOh5dJgl0JhApLpQtCWdn8vCE8WHx0lENx20vB6HkdqxA3GSu1BGj4
         0NYFzTzD4XsAVWUQ0ssbI3Bk5+2QYNSiNSkyOLmh1W8bvSitUDjW454B8MPZDufqLUVu
         H4GxJeaqeG8AHXKJe7d/EXp8jpwuxTl+zuEJuxeu+NGhhD4ZC5mltZoByb+Hy6KSIy2V
         tDRCGsDJlXIu7/2xPVRA0DQonESDcEBZOJa7lZ+D3jR5jydXHoYc6nzTlDw1guxeuAWi
         ccNw==
X-Gm-Message-State: AFqh2krD7LPZ1dRxiuZMBZ1Lgx4P577iCIiyEfs/evoO3qCP81hxdRVi
        JcmEzugFi9LiF7A09z1TuvsYig==
X-Google-Smtp-Source: AMrXdXvLMl+XxIwLawKqTfifPFsVANMXfBJPVgwMwjErAQJmnVhqH7IlAObsYxuVwi7GwdKbx76WBw==
X-Received: by 2002:a05:6a20:a68a:b0:b8:c859:7fc4 with SMTP id ba10-20020a056a20a68a00b000b8c8597fc4mr12475pzb.1.1674168712418;
        Thu, 19 Jan 2023 14:51:52 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b00192721d4f2dsm1375355plm.82.2023.01.19.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:51:51 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:51:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v11 018/113] KVM: TDX: create/destroy VM structure
Message-ID: <Y8nJhO1RhejehJxD@google.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
 <68fa413e61d7471657174bc7c83bde5c842e251f.1673539699.git.isaku.yamahata@intel.com>
 <20230113151258.00006a6d@gmail.com>
 <Y8F1uPsW56fVdhmC@google.com>
 <20230114111621.00001840@gmail.com>
 <Y8bFCb+rs25dKcMY@google.com>
 <20230117214414.00003229@gmail.com>
 <Y8cLcY12zDWqO8nd@google.com>
 <20230120004544.00003c50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120004544.00003c50@gmail.com>
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

On Fri, Jan 20, 2023, Zhi Wang wrote:
> On Tue, 17 Jan 2023 20:56:17 +0000 Sean Christopherson <seanjc@google.com> wrote:
> What I would like to clarify is: it would be better to have a mechanism to make sure a
> SEAMCALL can succeed at a certain point (or at least trying to succeed) as the 
> magic number would work like a lottery in reality.

Yep, you and I are in agreement on this point.  Ideally, KVM would be able to
guarantee success and treat TDX_OPERAND_BUSY errors as KVM bugs.
