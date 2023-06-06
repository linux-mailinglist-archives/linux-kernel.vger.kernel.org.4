Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA41E724DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbjFFUXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjFFUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:23:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B46B0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 13:23:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439bf89cb7so1103862b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686082986; x=1688674986;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7cMM+3Frap8CPDJIHI+z3vZmvyWyRt3GdKNUKBr4Jv4=;
        b=P4B9Sa4PUYVtwV6pKmSW1heOYBApHtr7MaB6q+TtcOijL4NDuHBov4KvNg+W0KfQoj
         T04Kje24RwrmpakzRA3wgmpd24XY/BPObZy138e596gkCSgnVdCwEAJTrCKMRXxDXOEs
         mUwqqSHfEbxEqzh8yg+nJrIkgvUH5QE8KFdmLnjowneNmG5S2qFJVlNtv4aXpSidPGwW
         KLpvzmslFj0nTJ9+Ol9xblSy2I+SV/tVljWdJvfqrK7Ecih91jFHSf3W+U2wb9Lyfrxp
         yK9VBJid3ILOkEdPau/jQSngS2+OXRioo+7Vyz0XSUMQNEw9YsKSVZvWVQk++ot4mE47
         MQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686082986; x=1688674986;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cMM+3Frap8CPDJIHI+z3vZmvyWyRt3GdKNUKBr4Jv4=;
        b=FnrROYcu0xZTcnRy+d6DLG3RwI9jGOXZr0ilxHanolu5J67CH2zNDkGDKNKA6SYdzx
         d6p5Ifn92x0okU5KvQYgy5XJgBNiUTt5g3owS4cABDAhM/dnP+N9p9hFyB7iNTjKTx7I
         ihNbOSFA+BjVcJBjj9KK/dqcqLq62/4IXhTUIU6YasAQAJ96GTRidxf3DEMLW/cIsMWQ
         8UBRinONr1rJX+YNhBMxaHPp/31i6tUUdafXEoJzwtWG5JSHQnTT51e5fbqVbk0Dg15H
         ADbqazyboCA6IGquM53b0Cs5ZR+9klrhIrYEVaIVzqtgOfnIL5zJLO1skVfHFfnhaqW3
         T6eQ==
X-Gm-Message-State: AC+VfDygd2jXRJAwuDPE56zF2nJjsCQekndkXTUGa2TxJrkG5xSEc8nJ
        bOLPxZaLLrzlmD9YDerCvnjsBQWOea7AFzsitHc=
X-Google-Smtp-Source: ACHHUZ6a3iq+Fc7SO2Oud/wSXecn/lSv+X9VE7/uzvDYcISChXTF6tG4xX5wXsxyJ5bZ1FTUMjrfzA==
X-Received: by 2002:a05:6a21:9995:b0:111:a0e5:d2b7 with SMTP id ve21-20020a056a21999500b00111a0e5d2b7mr4092602pzb.4.1686082985944;
        Tue, 06 Jun 2023 13:23:05 -0700 (PDT)
Received: from ?IPV6:2600:380:c07d:6a15:5a4b:a5e4:a3ae:c2e1? ([2600:380:c07d:6a15:5a4b:a5e4:a3ae:c2e1])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78749000000b0062e0515f020sm7162492pfo.162.2023.06.06.13.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 13:23:05 -0700 (PDT)
Message-ID: <c00870f9-9ae4-27b1-3362-444aa76d7671@kernel.dk>
Date:   Tue, 6 Jun 2023 14:23:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/9] pktdvd: Clean up the driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
 <ZH9JnPAL8x2GPSV3@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZH9JnPAL8x2GPSV3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 8:58 AM, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 06:45:40PM +0200, Andy Shevchenko wrote:
>> Some cleanups to the recently resurrected driver.
> 
> Anybody to pick this up, please?

I can pick it up, I'm assuming this is all untested?

-- 
Jens Axboe


