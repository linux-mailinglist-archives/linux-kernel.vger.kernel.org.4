Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC5610425
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiJ0VMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiJ0VLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:11:31 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812AFAE7;
        Thu, 27 Oct 2022 14:09:54 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id j12so2924019plj.5;
        Thu, 27 Oct 2022 14:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEWDWTIKyZoUo+9yWn2xTWEp8wSTgl14t0mUpd5Dx3c=;
        b=EG9c/Cwg6lNokY021ud/7jtW3xViZza5HZGX1yfOyzoI/TFNSVhUPakDOVED5P8sFb
         Zjwclh7NDK33rJQFdec/8kCnXluo4yZFSjY3BMQH7aI8qLExecCyX/WDJZSNuFclhke8
         FFEOu/azPIC0OmuR3zSSJ1dRjElPHS8+e67GyfPi1k246U634SBCGUy5IhNJZjtlNvWz
         7TB+uZTAJeNz8uBAxWxIZBuJdjsO6h2s2KTwNZ6OtpwBM1989Rqh1sf1to2pj2NLynr7
         0od30xHHda218JuQTA0I2JWJgCAtxYhIur+EPgxFOlWfFV0kTTyqUsxQqzCdIIpfQcSi
         g7Hw==
X-Gm-Message-State: ACrzQf21NvDE4QBjlmpLkEuMnhLn5YLad/3wniCymxQ2xypnHb9QoAy1
        EQrGk+ObnbuzEHMPy7chdo6K64mfaD4=
X-Google-Smtp-Source: AMsMyM6Nw3G4SI8cbjxOwI/QlYxebqpCEsbk5djSSfKW808xt0ObvBZNvXMIC9XBlOEwRfdYR0zMHw==
X-Received: by 2002:a17:90a:f414:b0:212:cacf:42c3 with SMTP id ch20-20020a17090af41400b00212cacf42c3mr12287158pjb.198.1666904993729;
        Thu, 27 Oct 2022 14:09:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b0017f72a430adsm1649961plg.71.2022.10.27.14.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:09:52 -0700 (PDT)
Message-ID: <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
Date:   Thu, 27 Oct 2022 14:09:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 03/17] ufs: core: Introduce Multi-circular queue
 capability
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1718196085461c37138c194c49146efa5c5503dc.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1718196085461c37138c194c49146efa5c5503dc.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> +
> +	/*
> +	 * This capability allows the host controller driver to turn on/off
> +	 * MCQ mode. MCQ mode may be used to increase performance.
> +	 */
> +	UFSHCD_CAP_MCQ_EN				= 1 << 12,
>   };

I prefer that the above flag would only be introduced after a need 
appears to disable MCQ, e.g. discovery of a host controller that is too 
broken to enable MCQ.

Since UFSHCI 4.0 controllers must support UFSHCI 3.0, shouldn't users 
have a way to disable MCQ, e.g. via a kernel module parameter?

Thanks,

Bart.
