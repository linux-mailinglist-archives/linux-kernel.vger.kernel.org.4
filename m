Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB536632D93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiKUUAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiKUUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:00:35 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA92C6D32;
        Mon, 21 Nov 2022 12:00:35 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id ci10so5169171pjb.1;
        Mon, 21 Nov 2022 12:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NU44cfudtq3+kL/Ca5qkgDeVjL7u3LaS55isxaZE3Q=;
        b=6/pbJ7+NxPM7gjrzW8ZVpX2xoQvXrZOU2Ka4FCHXEd4l6j2dCZELZ/4EfT3uSEZOoJ
         iy79KUuDrMS6bOCBPHV2cqjnIRvDXlKs82E9oMkkEbkXsVb1+YoMyKKrXoy1D2g6S/RJ
         dJuzvEBlR6ruXhiVEllZaukNFeWX3rSf1rF2iBndbknheDqA+sVstRmD2od+LKiwINER
         AxHaGziQhHzJZvu0OfMEOeIhAjsEbfOhqohbSo9fPdXsj8EaIXs4GUGhk/WfnRjgOVG+
         G2QGTYHWpv1uhatsE4YFBsvCjLTe30QWOl1/RadzAa0mFHzW0oBmbxQq7JXE8maTm1dq
         VNTA==
X-Gm-Message-State: ANoB5pnLtR2QBRf7hqYAbbASvCztp9lwx/XzMGvocnaSK+JC0hiziU9T
        WyEl5DeR50YKsIDaNWFwsv4=
X-Google-Smtp-Source: AA0mqf4zskjGaSZ7xf9xsEvpIAP+nhi6wrHmOytdL+C1UG9sSxJnJARRJ74/LngsmoLyB0cWTMSJSQ==
X-Received: by 2002:a17:902:aa0c:b0:180:4030:1c7d with SMTP id be12-20020a170902aa0c00b0018040301c7dmr271689plb.99.1669060834619;
        Mon, 21 Nov 2022 12:00:34 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:545d:bfd:7b53:8e94? ([2620:15c:211:201:545d:bfd:7b53:8e94])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b00186b138706fsm10148952plc.13.2022.11.21.12.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 12:00:33 -0800 (PST)
Message-ID: <4bba6b72-c361-f212-a8c3-9e33aab80c99@acm.org>
Date:   Mon, 21 Nov 2022 12:00:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/3] mmc: Improve block layer requeueing behavior
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>
References: <f30ec7fe7d834c1d8e116508500110cf@hyperstone.com>
 <c1e1281e-0977-cbf7-041e-db911ee722a7@intel.com>
 <d1a1340a-f5f8-6953-e066-b8c6095d63fd@acm.org>
 <5df2c4d5-f426-e3ea-8e6d-f772ec7091b6@intel.com>
 <bade026a-ec83-7516-d5ef-bb373df48a6e@acm.org>
 <1c9b3db6-3443-5580-08f2-42520d6a3318@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1c9b3db6-3443-5580-08f2-42520d6a3318@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 11:42, Adrian Hunter wrote:
> blk_queue_max_hw_sectors() does not allow it.

Right, I modified blk_queue_max_segment_size() in my patch series but 
not blk_queue_max_hw_sectors(). Adding a change for 
blk_queue_max_hw_sectors() to that patch series should be easy since 
that patch series already adds support for max_sectors being smaller 
than the page size.

Thanks,

Bart.
