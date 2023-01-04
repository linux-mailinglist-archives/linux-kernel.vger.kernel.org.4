Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5261565DBC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjADSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjADSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:02:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1273753B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:02:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so1547151pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OUIsT4Ue9m0VbhsGtpKU6oulTgEcGl2iMz66cGTxVE=;
        b=QZaCSJUVXl49NzYO9dU8W6BmW3G29oaEgmX7T1p7rH4t4MU2h3Nyr4o8urB0eRP3ST
         kh5an6BJuJ3sX808ciGc6NZBqrU8JrHj/xSvzrJCsJNW/zoB9e3Ygpb8feBl5Mz9+Wt3
         SCjTyIUhhB93UMzYLFGVt4fpR6G5/9csVXo1xdETzfEHXxi51RaCeDyxyiL0PLTCwwxs
         ApDXrE43RJSH7a+c/ibDDNljxowV3HcDUJiRnYJpowgzqzIKBA9Ta4Hu9XS7aOBg0ReI
         YBCScKWz60WtZqCttbCYsZccq5yk72r8/Fcccvu1ig4YiyeQY3xDl+NGmCQrdgzDkITd
         p2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OUIsT4Ue9m0VbhsGtpKU6oulTgEcGl2iMz66cGTxVE=;
        b=5a+OMuJhhVbJUn8ht2/ugJQLvVQh3jxNpBfyllBifTPvhO7z5U97osLV1HfjScQXVw
         iyFFtAqLl1UMJwq5mg2/8wEq37cCuvkbnTBqHuTHpsX5pzbK6f+hR6RnwqCo+9a1221c
         AG5CTVZlmu8lcXrKgNiCk3UVmnKl3/QkSVOjOY2Fv8o0z5eE1LwJW1/ZFYIJpgeQWDic
         ezyyGOw+jHwz0zadCtfY5KOUF1wnfmnS4EPXlWpf+2C11xUBoA4wrhSuHrElqN1tjl9h
         Ernkrmgds0L7fWI0+mQV2c6KLhurD/7+JNFmU60lKu71BS2LCwbpfDo+/MI6SSJ3yEEk
         rIlg==
X-Gm-Message-State: AFqh2krLBVcR+UqJaubcU76bYDB1XHD8bFhUJeFZfv77I/awULbgHe2F
        P2CFzLWnRiDfUTt1NcCo7snjL5xve8hw0T1o
X-Google-Smtp-Source: AMrXdXsVzYxPh2J7HnR4Y4xXdAV5Bt7ZJbRGFAoR8vE/WDaMJt2cDP+M+nIp2KZshC7lssd3ISP7Ag==
X-Received: by 2002:a05:6a20:3b25:b0:b4:1a54:25c6 with SMTP id c37-20020a056a203b2500b000b41a5425c6mr1488576pzh.1.1672855355120;
        Wed, 04 Jan 2023 10:02:35 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j22-20020a635516000000b004a3510effa5sm4943943pgb.65.2023.01.04.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 10:02:34 -0800 (PST)
Date:   Wed, 4 Jan 2023 18:02:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     mlevitsk@redhat.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 28/32] KVM: SVM: Require logical ID to be power-of-2
 for AVIC entry
Message-ID: <Y7W/NinWOnJMtUk8@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-29-seanjc@google.com>
 <f1f1a33134c739f09f5820b5a4973535f121c0da.camel@redhat.com>
 <b002fd18c2abdfe5f4395be38858f461b3c76ac3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b002fd18c2abdfe5f4395be38858f461b3c76ac3.camel@redhat.com>
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

On Thu, Dec 29, 2022, mlevitsk@redhat.com wrote:
> On Fri, 2022-12-09 at 00:00 +0200, Maxim Levitsky wrote:
> > On Sat, 2022-10-01 at 00:59 +0000, Sean Christopherson wrote:
> > > +	} else {
> > > +		cluster = (ldr >> 4) << 2;
> > > +		if (cluster >= 0xf)
> > >  			return NULL;
> > > -	} else { /* cluster */
> > > -		int cluster = (dlid & 0xf0) >> 4;
> > > -		int apic = ffs(dlid & 0x0f) - 1;
> > > -
> > > -		if ((apic < 0) || (apic > 7) ||
> > > -		    (cluster >= 0xf))
> > > -			return NULL;
> > > -		index = (cluster << 2) + apic;
> > > +		ldr &= 0xf;
> > >  	}
> > > +	if (!ldr || !is_power_of_2(ldr))
> > > +		return NULL;
> > > +
> > > +	index = __ffs(ldr);
> > > +	if (WARN_ON_ONCE(index > 7))
> > > +		return NULL;
> > > +	index += (cluster << 2);
> > >  
> > >  	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
> > >  
> > 
> > Looks good.
> 
> I hate to say it but this patch has a bug:
> 
> We have both 'cluster = (ldr >> 4) << 2' and then 'index += (cluster << 2)'
> 
> One of the shifts has to go.

The first shift is wrong.  The "cluster >= 0xf" check needs to be done on the actual
cluster.  The "<< 2", a.k.a. "* 4", is specific to indexing the AVIC table.

Thanks!
