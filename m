Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DF6CA983
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjC0Pr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjC0PrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97124686
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679931994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suVVIjRV3oKGbuJwHAWeWKYJQxupg5L1pR21dbVXNSs=;
        b=G2u5g+M6WFIHMQkCDHSq21j61oS8WW0ounvZ6mHJcEXKb1lB4CDJ9ZGXkIZ/xLab1cBXy4
        O7j6wL4ikiO+b5xcauivNmsNh6fjvKxNRzOMbDNbKueEe31mlqK6Sktq8JVWU0GmBPz51t
        fQX+nIj7GBHA8sUC1/CAtVqCRnHnT30=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-DquvU-s_MnS9wOSv1-LxvA-1; Mon, 27 Mar 2023 11:46:33 -0400
X-MC-Unique: DquvU-s_MnS9wOSv1-LxvA-1
Received: by mail-wr1-f72.google.com with SMTP id u27-20020adfa19b000000b002d3b9266941so816529wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suVVIjRV3oKGbuJwHAWeWKYJQxupg5L1pR21dbVXNSs=;
        b=kIUX+0J7rAIKoB6bgc19XJd2oNvrSkciOa9oxo8O6wG/s6WDIAS3z9y8VR5KcrXwTl
         36N2phLIf2Qg1TEfwk8gIRLCDQRuPbZmvXDD/+q7R3LF5UGHrrBhftyIoVAoquMbWUfk
         HQCk5wEZ/sPlnlTv1AzVkTokA8scbBblsaiGmM2cf+FNbTZ4DsoiqEzirTqALm5wu4W/
         gv74aQhlhfSTJkdhnMO0RWQGKGRGky/UDzy03gRPFJiV2P7nAlsWeyufpjFxwv94ZXbL
         p1npFaH4CfU7IYWWhjh/IoWhMMgTX9ZU1ZDgZvs7T+V+aLhLad7/3+TDMHuAUrCcbPGi
         mI7g==
X-Gm-Message-State: AAQBX9exGjhRmdfNs4Os7psE8x+yNAwIG5Ynp4PhED1BUJ9NTpB7Oh/M
        pZKiMqFjOq93MRBEQ5BuWl9Ohk1Lbui1yCY5bSz2lmKmgYrh/QBStnMKl1fhF5RXw3lF0yJx+xy
        0vsRYcp0CWdmGzPc0Sdp/d8ur
X-Received: by 2002:a5d:684a:0:b0:2ce:fd37:938c with SMTP id o10-20020a5d684a000000b002cefd37938cmr10101890wrw.50.1679931992546;
        Mon, 27 Mar 2023 08:46:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIogvBhFKiM1BfoGRTLIj1Va5aO8952L7+RRJrVJ3LVX59i+b+GLF0/519SVZbSl6UgZQ0XQ==
X-Received: by 2002:a5d:684a:0:b0:2ce:fd37:938c with SMTP id o10-20020a5d684a000000b002cefd37938cmr10101874wrw.50.1679931992242;
        Mon, 27 Mar 2023 08:46:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id g16-20020a5d4890000000b002de99432fc8sm5812194wrq.49.2023.03.27.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:46:31 -0700 (PDT)
Message-ID: <c3705204-8803-8115-5c47-de73bd4523a7@redhat.com>
Date:   Mon, 27 Mar 2023 17:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20230322011440.2195485-1-seanjc@google.com>
 <151c3b04-31db-6a50-23af-c6886098c85c@redhat.com>
 <ZCG2D1PyWobdb8jk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZCG2D1PyWobdb8jk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 17:28, Sean Christopherson wrote:
>> On 3/22/23 02:14, Sean Christopherson wrote:
>>> Revert the FLUSH_L1D enabling, which has multiple fatal bugs, clean up
>>> the existing PRED_CMD handling, and reintroduce FLUSH_L1D virtualization
>>> without inheriting the mistakes made by PRED_CMD.
>>>
>>> The last patch hardens SVM against one of the bugs introduced in the
>>> FLUSH_L1D enabling.
>>>
>>> I'll post KUT patches tomorrow.  I have the tests written (and they found
>>> bugs in my code, :shocked-pikachu:), just need to write the changelogs.
>>> Wanted to get this out sooner than later as I'm guessing I'm not the only
>>> one whose VMs won't boot on Intel CPUs...
>> Hi Sean,
>>
>> did you post them?
> No, I'll get that done today (I pinky swear this time).

Ok, you can also send me a pull request if you prefer (or I can apply 
the patches to kvm/next myself of course).

Paolo

