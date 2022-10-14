Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704075FF3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiJNTDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJNTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:03:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28A1905DD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:02:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m6so5795386pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=93SM5edoQTmh30dhmcftbv07FMloClt4sRz/Es4IFlM=;
        b=BUJRV0Pc2cbfpCvcp0VnINHf8OFz/twYIlfpd4Oyf50KGIddch6YqP9L/dp6C+D7Md
         GmPFvjkicX1rvEyRJDsvivlcJW5pBFTP2t1E/IBV3J9JoNBff6RYngi9r7psUHt8UOGR
         ruYq+PfEDjUWW1GkfJwZiSah0WpONl7pW00iqVCpZ0jraczJaw0Iaz08dPZus3Msxg4Z
         ss8BCwyflYryxfQ3BV2WEcYL1nRSsT63Dg9W8Y4wlKimRoUha2ibmRsVNUcy9PD0Grsc
         OPtdEtjlbt0fKRZ3Q9s9hyEsPjyzlQTMJEiTdHaDM561/iCSmwZ420LAJRIBk7iW8VL7
         25QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93SM5edoQTmh30dhmcftbv07FMloClt4sRz/Es4IFlM=;
        b=zoc12WFbZbD8OOmkQsAI3lRBv75gB+me3XTLvjZzbwSH2w7V3kcuYJBKN8JsMt5pgi
         EK8fWc0trMkCfyaUGyBOkVuo+suM2qe1MHXR4ujdLrGRh/eGIuyLV3bC0mIQirYjbfT/
         ejcWJ2nCqrYc97MzMjN99q3LwlXp20VAoGO9yWUC/b0RFhKHpeTXIP3G76MEsvh7HrfO
         H+gUOElGisHR0weHWMb6vjbso/q1Hy5Qw4GDL2BQ86QDAAOgV31hStaAcuEqU1DWupSt
         Wc4khmFdeon+XiqtSou5t2tPs4PaxKBOOK3wS3Er+O8Jl5Hj2U7azu3mxLC6uuMJjKzU
         m+pw==
X-Gm-Message-State: ACrzQf16pE3OtAQvx09sVCjcFPZy5GVQUWJH3bdtUvC9U1VPLfWG3oTz
        Tdkv38eA0YHyFJ/SDF3Ov7yKSdAd5ZsuYg==
X-Google-Smtp-Source: AMsMyM71eRcCLDDCqpb7XXz4/MQpa6Z2VN36ZgDsI/P22mjS9jZp1Izpx/9ABooVI5nyhiKSWq3Tsw==
X-Received: by 2002:a63:454d:0:b0:43c:e834:ec0 with SMTP id u13-20020a63454d000000b0043ce8340ec0mr5999924pgk.270.1665774178987;
        Fri, 14 Oct 2022 12:02:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g17-20020aa79dd1000000b0053e5daf1a25sm2087262pfq.45.2022.10.14.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 12:02:58 -0700 (PDT)
Date:   Fri, 14 Oct 2022 19:02:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
        David Matlack <dmatlack@google.com>,
        "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] dirty_log_perf_test vCPU pinning
Message-ID: <Y0myXiIjlT8pYyr8@google.com>
References: <20221010220538.1154054-1-vipinsh@google.com>
 <DS0PR11MB63735576A8FBF80738FF9B76DC249@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y0mPqNRSgpArgyS8@google.com>
 <CALzav=dU2-3avKGT2-AxO8d_uVH9bmYaO=ym8pPFM8esuSWP=A@mail.gmail.com>
 <CAHVum0d2Jfr=WVxKxvnmwGKzPfV3vN5dbz11=rdcW6qoSoobew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0d2Jfr=WVxKxvnmwGKzPfV3vN5dbz11=rdcW6qoSoobew@mail.gmail.com>
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

On Fri, Oct 14, 2022, Vipin Sharma wrote:
> On Fri, Oct 14, 2022 at 9:55 AM David Matlack <dmatlack@google.com> wrote:
> >
> > On Fri, Oct 14, 2022 at 9:34 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Fri, Oct 14, 2022, Wang, Wei W wrote:
> > > > Just curious why not re-using the existing tools (e.g. taskset) to do the pinning?
> > >
> > > IIUC, you're suggesting the test give tasks meaningful names so that the user can
> > > do taskset on the appropriate tasks?  The goal is to ensure vCPUs are pinned before
> > > they do any meaningful work.  I don't see how that can be accomplished with taskset
> > > without some form of hook in the test to effectively pause the test until the user
> > > (or some run script) is ready to continue.
> >
> > A taskset approach would also be more difficult to incorporate into
> > automated runs of dirty_log_perf_test.
> >
> > >
> > > Pinning aside, naming the threads is a great idea!  That would definitely help
> > > debug, e.g. if one vCPU gets stuck or is lagging behind.
> >
> > +1
> 
> I also like the idea.
> 
> Sean:
> Do you want a v6 with the naming patch or you will be fine taking v5,
> if there are no changes needed in v5, and I can send a separate patch
> for naming?

Definitely separate, this is an orthogonal change and I don't think there will be
any conflict.  If there is a conflict, it will be trivial to resolve.  But since
Wei provided a more or less complete patch, let's let Wei post a formal patch
(unless he doesn't want to).
