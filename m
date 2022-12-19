Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A14651403
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiLSUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiLSUfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:35:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CC8FF1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:35:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so10075966pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4/RvF7OdL8ZsVQTFbE3WmWB2bp0qhh0RuuBTb1Sq20=;
        b=Vi5Y9//6yRDpyzzPmeR4sM5gmu8JRv/ajtFEAR8wRoTsozhTEHZqnw/zazaovFOk7O
         xhE8JduaCbrYTq4g5eb+JpOkWSShPgQjeKBu9S6MUx+9JWr8YQlg523iV/yTt10Y/nQ4
         oGz+AFSHU/V4cy5Sp6Gl8UMoV9tEkEC7fvm09nxLDYD4MfTWM6+Zc0g9RyqVe0zunw37
         NQnUy7yCkZ5zvr4/Vo3yP2ExIQKAq1c7mdV16s0iCvakT8AA7ReaV0m3f9WeiKhmJ/jC
         CRm5amtk3y1mlXd8HBaeUllHA66nA9W/9yo9+Xk1eDLh8PhYSTUXKxkhqr1I9VJC7rZP
         m1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4/RvF7OdL8ZsVQTFbE3WmWB2bp0qhh0RuuBTb1Sq20=;
        b=3ARUYVIqWqBufY1PHzygyMcajh1DRKAAFeGj/674M72t2FxsnRZEyTiM9DTSIz5dF1
         3jsi3mNEYAba/8prjqPc+K63uGyryCCz875SIxsxIi2j8qP1Q98sNjERO4cSVqYZDaIl
         SSR3RNNW7ail3xYUWADbhWMCFFzS5fuudd6yOtZkWSEuXudKdu2t+o/OK+Eb1qqjxonj
         StlAC+C58ThBiJGKYCP04g5NiZrBK89JXl7COD6QwdX8SK83CfisN/Xz7WaI0HsjUQJ4
         +gFS4suTetL2M4GRImgRIxw+kgXx5P8sKEYh9OJPT8YTHwXHWO32+GIn83eVHxQUJv7U
         a/gw==
X-Gm-Message-State: AFqh2kopKOzdqhVnvqxuAQ0PTclGzkyZim7Mv1P3TsIeQYFh6oRn8CNx
        opjP/Bs/rI04dwmk5e8Ul0RX7w==
X-Google-Smtp-Source: AMrXdXtQdEbVhElOhzQhEy8Wo4uK7K+kgOMOoZx3nWOUthbbYGaNBWgJgVnAbc47UQqzcG9LNViwCg==
X-Received: by 2002:a05:6a20:4407:b0:9d:c38f:9bdd with SMTP id ce7-20020a056a20440700b0009dc38f9bddmr2109805pzb.2.1671482151009;
        Mon, 19 Dec 2022 12:35:51 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r8-20020a654988000000b0046f56534d9fsm6771949pgs.21.2022.12.19.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:35:50 -0800 (PST)
Date:   Mon, 19 Dec 2022 20:35:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] KVM: x86: add KVM_CAP_DEVICE_CTRL
Message-ID: <Y6DLI7yA58NZmIVh@google.com>
References: <20221215115207.14784-1-wei.w.wang@intel.com>
 <Y5ynFUdZXpN5HP7F@google.com>
 <DS0PR11MB6373187B53B558EF73FB202BDCE59@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB6373187B53B558EF73FB202BDCE59@DS0PR11MB6373.namprd11.prod.outlook.com>
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

On Mon, Dec 19, 2022, Wang, Wei W wrote:
> On Saturday, December 17, 2022 1:13 AM, Sean Christopherson wrote:
> > Rather than hardcode this in x86, I think it would be better to add an #ifdef'd
> > version in the generic check.  E.g. if MIPS or RISC-V ever gains KVM_VFIO
> > support then they'll need to enumerate KVM_CAP_DEVICE_CTRL too, and odds
> > are we'll forget to to do.

...

> > The other potentially bad idea would be to detect the presence of a
> > device_ops and delete all of the arch hooks, e.g.

> Yes, it looks better to move it to the generic check, but I'm not sure if it
> would be necessary to do the per-device check here either via CONFIG_KVM_VFIO
> (for example, if more non-arch-specific usages are added, we would end up
> with lots of such #ifdef to be added, which doesn't seem nice) or
> kvm_device_ops_table.
> 
> I think fundamentally KVM_CAP_DEVICE_CTRL is used to check if the generic
> kvm_device framework (e.g. KVM_CREATE_DEVICE) is supported by KVM (older KVM
> before 2013 doesn't have it). The per-device type (KVM_DEV_TYPE_VFIO,
> KVM_DEV_TYPE_ARM_PV_TIME etc.) support can be checked via KVM_CREATE_DEVICE,
> which reports -ENODEV if the device type doesn't have an entry in
> kvm_device_ops_table.

If that's how we want to retroactively define things, then KVM should unconditionally
return 1/true for KVM_CAP_DEVICE_CTRL since KVM_CREATE_DEVICE is provided by
generic code.
