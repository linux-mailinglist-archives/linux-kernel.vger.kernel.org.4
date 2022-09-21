Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6775BF806
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIUHpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIUHo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:44:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B74DB65;
        Wed, 21 Sep 2022 00:44:51 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 49FD91B00215;
        Wed, 21 Sep 2022 10:44:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1663746285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnGbC6DaaST+f3TKNbuJYJjswXZQ3tjchI+CtHy59hc=;
        b=foXLrmtENA4hr4Ca1Oax+awTlkh46H2D9gkqxkXS0FkDdLDS7tgjSV7dRkbmsDla960FQl
        XdRl1ON4Mrj5J7wBsEcHsQAiRLETC0PaV4UZeydpY1ieuS493R9//LlNVbcJJBdv5MiGGK
        XXOiC8PPbhSbFyyxvhheovI1Cm/Rcpc+mUcvsugjpjdGddNkCtVUOnzlMvL7Pe7ScRGxxj
        OlM9O4+cJKoxT2yBs+kFRjQhDHTgw9Faf6Gq+LfLYkwtIfjiNWg7XdnwyA7aoriJkyHyBp
        CL33EbhK7Bmmi7y6coh5TDqUhZjoMRWbdaF5HPbPXcc/R5nhbB895XudAzhNZw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id E22E9634CAA;
        Wed, 21 Sep 2022 10:44:44 +0300 (EEST)
Date:   Wed, 21 Sep 2022 10:44:44 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov8856: Add runtime PM callbacks
Message-ID: <YyrA7PQP3yrQM0XW@valkosipuli.retiisi.eu>
References: <20220920020002.710533-1-hidenorik@chromium.org>
 <Yyl7spRDgJ+R39Pj@valkosipuli.retiisi.eu>
 <20220921013212.m7sqb4v7hk5rddfa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921013212.m7sqb4v7hk5rddfa@google.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1663746285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnGbC6DaaST+f3TKNbuJYJjswXZQ3tjchI+CtHy59hc=;
        b=fnERBLw1zhKIvk3NKKFQMs5LEZ/mclKIvT75C49LwOkRTETDjX+ZSxR2S4JNDtYPgRhKkT
        eHwi6RKkl1Bo/fzr+3ZB8H9brRC5J+PjpT6PJbII4iMPLbpsnUzkTJ46aTOde2WflWihUw
        tvGlZWqj+a50DVlXDWFXN/dNS6Bc4vefg5Temv3YPh5olfbUZjpkIHkSuilAq5rv0/7Tab
        05Vl3aQhozfIYvHFjePq3EHQSD4R1X/4lNTKKv0MLtkEwRdBSoosfOn6CKDHlqW9lroOvp
        30eQ5snpTbKOIsq3pBDQcy20uTLHHxoIqmPKW+ZzLpxicJuZ+c80LAgdozE1Kg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1663746285; a=rsa-sha256;
        cv=none;
        b=UDL5S5Nu7tyIg2N6Y1gxL4DHYf9VoOeGJIq5T0HGvMYvz6RWDiI4tLsfu3hQzyl9P+6/Er
        oJss2HaHjkoIGI12RDCOB7eAPMtIX7Ki4vhIlEzO6JfO4CB5eNuwhe1EJ012X5vb/f2vN9
        SHnx8rBTL/faYpdisIYJWUy66zXaFGSYQQpsk9ypkTChMXgFRdoqcfPCTM2P45gA9wGqzL
        0T9WaejVWG8kuPb/yxedsXsPc0NcDoLJo6+pqxl6qrpeF8lhoyb3V+xtS6okCDpgt+8KRq
        BeBZoDGpM3iqmAVapmjwxfEtM9yy6fdjKO1bMyTv+RuoKKZMFKAaVmRugoV51Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidenori,

On Wed, Sep 21, 2022 at 10:32:12AM +0900, Hidenori Kobayashi wrote:
> Hi Sakari,
> 
> Thanks for your review!

You're welcome!

> I'm guessing that we want the
> same for __ov8856_power_on().

Yes, please!

-- 
Sakari Ailus
