Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4360663C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJTQuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94E5F101
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666284600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uoGto+gNH92mAm1Kdu+EjWKJigMkRDwEWaF/cwWxdwc=;
        b=GYdfQh3U4RN6vKhH1QPVMza4P+jvKhYtUM58UCFv8J+4NOt1HDhzyvKvd2q7EJtbUac+06
        EZsnJUnlC2DbHGicn0R3kFvvw1XXOJUannN/yITK36A7cAD2IbccN44AKJDehWCwak3P1J
        VMAvtVMIgkcznbWubztknhvY/IZqxWE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-RMD7ltNGMPSmTjChGfzgag-1; Thu, 20 Oct 2022 12:49:58 -0400
X-MC-Unique: RMD7ltNGMPSmTjChGfzgag-1
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso363748ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoGto+gNH92mAm1Kdu+EjWKJigMkRDwEWaF/cwWxdwc=;
        b=Bzvtecw6b+z7Dt1ANxpt1mfQMXdGXIPXMzVjqaPZHCVEBgdV8edjyScrxDy7hFzSuc
         9QhANQFVAINYvQnzQZf8sO8i0zatbq4xlRlRJxanHjrDLG5VPkPSpdBhTNS6XKIWjWIb
         EWpWhQ2i2ZNvVTOhsCSgJzKl5cpeOv657v12vvkDR9LzL6m/s4ZHfuiLbjl0NMXw2mRl
         cOexlP5ceRSCZ/VTxo3AiMqtNs2byJZmEdJnGrg2San/4AJ8gHUMUsae/DQ1hxfNRkj2
         ymvg0dEd6GnEKe83b3pRQkG85vOElnUtMt0QHlCVTpiMa1D2u/aTiQJ8oNzmBjsq6bwq
         VDsA==
X-Gm-Message-State: ACrzQf3fQuw/N9vx9k0yPqBGUV5qiIPyLjfXgcmkOMTcUNC0sOzxF6YX
        ZizgYu28Cn0iphUlIUViizlEQ5eOpUh4gv/IHOzYqmzZcReNqJNUnLk61iLmN8kJAv6SyLGwXuM
        v18btMxrgDH7rC9eFzIxzB3QO
X-Received: by 2002:a05:6638:4987:b0:363:c403:28ff with SMTP id cv7-20020a056638498700b00363c40328ffmr10097983jab.235.1666284597638;
        Thu, 20 Oct 2022 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5f69+U/H3YHmxW+EIukcVAqLTXZEmABQS3o/TzzGrb3p1R4FOeCnxcVZxE631gJUxtqBzN1Q==
X-Received: by 2002:a05:6638:4987:b0:363:c403:28ff with SMTP id cv7-20020a056638498700b00363c40328ffmr10097946jab.235.1666284597136;
        Thu, 20 Oct 2022 09:49:57 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id y19-20020a056602121300b006bb5af55ddfsm3477224iot.19.2022.10.20.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:49:56 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:49:54 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <Y1F8MqeHxj5IaLtx@x1>
References: <20221017112449.2146-1-johan+linaro@kernel.org>
 <20221017112449.2146-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017112449.2146-3-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 01:24:49PM +0200, Johan Hovold wrote:
> On Qualcomm platforms like SC8280XP and SA8540P interconnect bandwidth
> must be requested before enabling interconnect clocks.
> 
> Add basic support for managing an optional "pcie-mem" interconnect path
> by setting a low constraint before enabling clocks and updating it after
> the link is up.
> 
> Note that it is not possible for a controller driver to set anything but
> a maximum peak bandwidth as expected average bandwidth will vary with
> use case and actual use (and power policy?). This very much remains an
> unresolved problem with the interconnect framework.
> 
> Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> path for now as it is not clear what an appropriate constraint would be
> (and the system does not crash when left unspecified currently).
> 
> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

