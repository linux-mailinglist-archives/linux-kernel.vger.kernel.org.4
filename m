Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B866A88B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCBSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBSqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:46:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028A515EE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:46:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z2so209058plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677782806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFVy1NChotHCYXJVQP117OWHfuZeq72Zl4CyzCN0yEs=;
        b=E/TPH0VOujJi/1gILhW/BBDnZbA8+X5I8p7gzsGHMMaNFhFsUucvL1r0lSqCbUmiGa
         zjHNnwXCd/KPsZOjA83iEI4BFemkPoza3O0OwSfzN77hlNrfQ/ik2Yza2mdTB7O+5C95
         M1jwKWJF/I/PXx/a6C/14/GIGLZyhhiETCd7IuHcEAhZRAVBgVI2vufFwm96qquV5YEN
         K+iTt53GlsWdyYgykGSrDOun8EK4D9IGKhrbIs3WpRCxA2DmMEy3SRk+DWk3pJ9oEIMC
         6XEbw/t0C2xGp6Ww2lHcUuB6DKascpj75g0ojw7qP+OaleSW/yQBLbPpqjfhdC+u3Qi/
         KP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677782806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFVy1NChotHCYXJVQP117OWHfuZeq72Zl4CyzCN0yEs=;
        b=eJQFJViaZ4EYor6E/GVnLyBhaqfb6IWJvfwIiD1/dAR237jqqmSbX3q70IaEDMoBB+
         PBr0ZvDzKxJs9zovJmJmdFyCKrAiajUXrfDdPvK28O1pNHleLOO9sxynpCW73xFX3clV
         1AE8lM2cQF/5ZrC4T/mzIi0Autc9M5SugpA3SwI+VgQCnqyCNaBWQSLpQMEIF/Ci02is
         oeCJBf4HcY41hHYFEOYTc4d6QnfLp8tZcH4nCXR08sXyT0Bg+8oba+D8diZldHa4GO4N
         t9F+ORyq/5QQsDO4ceq2G3aqAHQ+r30hWIsZdyXb2+PKzTA8x46Ig5aagGfrYvavOGPj
         +zqA==
X-Gm-Message-State: AO0yUKXKV71LW1sKfMMro6AI0aaw7jYvDmQS455tCnCC9b3iSFakX/6L
        WQwf+T3RXAOyjfSrosWGGFK8aQ==
X-Google-Smtp-Source: AK7set8944u/7OAA9BNVygtciGCBE+hUBln/eftAicEsEPtx7EZ06zucDbjYpwuXA1F7RaPborv9Ow==
X-Received: by 2002:a17:903:248:b0:19e:748c:d419 with SMTP id j8-20020a170903024800b0019e748cd419mr2560811plh.46.1677782806139;
        Thu, 02 Mar 2023 10:46:46 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id jy8-20020a17090342c800b001990e1aeae4sm49221plb.47.2023.03.02.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:46:45 -0800 (PST)
Date:   Thu, 2 Mar 2023 18:46:42 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Shier <pshier@google.com>,
        Anish Ghulati <aghulati@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Anish Moorthy <amoorthy@google.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Babu Moger <babu.moger@amd.com>, Chao Gao <chao.gao@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Guang Zeng <guang.zeng@intel.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jing Liu <jing2.liu@intel.com>,
        Junaid Shahid <junaids@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Leonardo Bras <leobras@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Li RongQing <lirongqing@baidu.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Luczaj <mhal@rbox.co>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paul Durrant <pdurrant@amazon.com>,
        Peng Hao <flyingpenghao@gmail.com>,
        Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>,
        Robert Hoo <robert.hu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/process: Add a maintainer handbook for
 KVM x86
Message-ID: <ZADvEmVmCOB5Db6z@google.com>
References: <20230217225449.811957-1-seanjc@google.com>
 <20230217225449.811957-3-seanjc@google.com>
 <Y/AvSjsgLBWECLq2@google.com>
 <Y/VhzWCcC7LtGm4D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/VhzWCcC7LtGm4D@google.com>
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

On Tue, Feb 21, 2023, Sean Christopherson wrote:
> On Sat, Feb 18, 2023, Mingwei Zhang wrote:
> > On Fri, Feb 17, 2023, Sean Christopherson wrote:
> > > +Coding Style
> > > +~~~~~~~~~~~~
> > > +When it comes to style, naming, patterns, etc., consistency is the number one
> > > +priority in KVM x86.  If all else fails, match what already exists.
> > > +
> > > +With a few caveats listed below, follow the tip tree maintainers' preferred
> > > +:ref:`maintainer-tip-coding-style`, as patches/series often touch both KVM and
> > > +non-KVM x86 files, i.e. draw the attention of KVM *and* tip tree maintainers.
> > > +
> > > +Using reverse fir tree for variable declarations isn't strictly required,
> > > +though it is still preferred.
> > 
> > What is the 'reverse fir tree'? Maybe, "Reverse Christmas Tree" is
> > better to understand.
> 
> For some parts of the world, but not all.  For this, I want to follow whatever
> description the tip tree uses, which as of today is "reverse fir tree", as this
> is really a qualifier on the tip tree rules.

Some parts of the world is correct. In fact, in our world, we use
'reverse Christmas Tree' more than the other. Check lore.kernel.org:

https://lore.kernel.org/all/?q=reverse+christmas+tree
https://lore.kernel.org/all/?q=reverse+fir+tree

You will find the former is used 10x more frequent than the latter.

Overall, I don't hold a strong opinion immediately after I understand
the meaning of 'reverse fir tree' and I do agree that it is safer to
follow the Linux Tip Tree Handbook.

Also, thanks for the whole guideline.

-Mingwei
