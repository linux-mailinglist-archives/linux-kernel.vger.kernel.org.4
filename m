Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157BA60C7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJYJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiJYJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB451CB1C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666689018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7V3TCPoYLGECIiPNR0pPoNV1DhkNdk1bP7qY02/4Jc=;
        b=SiI5Up5wtRC2+7UgCMyryBxDrq9Pa44KwCa0AInN3KgnhxbEz8xxiJT6FKiDdHFX/munC4
        LVNuJSsaPKmzTiLlPv4sybkuH53hOSGoVco3gyXIEsOGKjB7V/5D3Xrmb3XIwAkn1lFTPZ
        PxKh9u43Kz7mGm/c3xP1QYoGTOXjTwA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-haoR1TPOMBCPJHK-mZjbVg-1; Tue, 25 Oct 2022 05:10:17 -0400
X-MC-Unique: haoR1TPOMBCPJHK-mZjbVg-1
Received: by mail-pj1-f72.google.com with SMTP id q93-20020a17090a1b6600b0021311ab9082so2484142pjq.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7V3TCPoYLGECIiPNR0pPoNV1DhkNdk1bP7qY02/4Jc=;
        b=Ytp6p2dIuF3C2fG1/u4YteRRJBDYECHzDApReKe3YuFe44fmJxUI+4vGeroGkmmEm2
         gf1ozUAWZuTwU4HuxH4C/tyd2oPBpNPX0mAXAWmFvMn8GqfTeIROU+9rKkPhU2TegPw6
         CfWjm2XdXBZl61mzsZjsoIC4Y1D3DntuTMGJrtsSp2SGDa8mkaUX/fdBVmOQTLmUnbtp
         305VWwf0OVid/XY8o2PSIpA2UE7fw8fcH3n1mzGrk61yTMF8wyDsv73a/dbdzEhmHKOX
         sE0PWgaWy7uKDN7mQn8kjmBK3/KXIRqEEYIrcIaKHFtzgHp0QPLecuVHU03Xw6JNfRHh
         jP6g==
X-Gm-Message-State: ACrzQf2IY3lMaBOxu30GkDBaqN0H5wHVwtZlhPkP5tOt6CqVbG47wLhM
        JbDJz1UqUXVzQsZeYuE8jjMnTRclGxTwZh2C1xs2aZIlem+ruXJFGvvOxrsnQqwuJwLW+ezkSuH
        hhy42Fy/QAQ3V4/Bw6bG/M+u4VSIS+wWsaI8ZaUCz7pwJbZ/Dw+X393adt3tLuyZEragJOyHing
        ==
X-Received: by 2002:a17:902:b70c:b0:186:8bb2:de36 with SMTP id d12-20020a170902b70c00b001868bb2de36mr16394373pls.106.1666689014793;
        Tue, 25 Oct 2022 02:10:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Uf0Aklz9O3y8UewgVP1XxC7F2FNzzxj/Xw1kWqSytxMwF6q8lWgpfjsbq4XK1+qBjE0puww==
X-Received: by 2002:a17:902:b70c:b0:186:8bb2:de36 with SMTP id d12-20020a170902b70c00b001868bb2de36mr16394337pls.106.1666689014334;
        Tue, 25 Oct 2022 02:10:14 -0700 (PDT)
Received: from [10.72.12.79] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gd2-20020a17090b0fc200b002009db534d1sm1031910pjb.24.2022.10.25.02.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:10:13 -0700 (PDT)
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
 <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
 <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
 <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
 <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
 <cd5ed50a3c760f746a43f8d68fdbc69b01b89b39.camel@kernel.org>
 <7e28f7d1-cfd5-642a-dd4e-ab521885187c@redhat.com>
 <8ef79208adc82b546cc4c2ba20b5c6ddbc3a2732.camel@kernel.org>
 <7d40fada-f5f8-4357-c559-18421266f5b4@redhat.com>
 <CAKPOu+_Jk0EHRDjqiNuFv8wL0kLXLLRZpx7AgWDPOWHzJn22xg@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <db650fa8-8b64-5275-7390-f6b48bfd3a37@redhat.com>
Date:   Tue, 25 Oct 2022 17:10:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAKPOu+_Jk0EHRDjqiNuFv8wL0kLXLLRZpx7AgWDPOWHzJn22xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/10/2022 15:22, Max Kellermann wrote:
> On Tue, Oct 25, 2022 at 3:36 AM Xiubo Li <xiubli@redhat.com> wrote:
>> Currently cephx permission has already supported the 's' permission,
>> which means you can do the snapshot create/remove. And for a privileged
>> or specific mounts you can give them the 's' permission and then only
>> they can do the snapshot create/remove. And all the others won't.
> But that's a client permission, not a user permission.
>
> I repeat: the problem is that snapshots should only be
> accessible/discoverable/creatable by certain users (UIDs/GIDs) on the
> client machine, independent of their permission on the parent
> directory.

Hi Max,

Yeah, the cephx permission could cover this totally and there is no need 
to worry about the user id mapping issue.

You can allow the mount with specific client ids, "client.privileged" 
for example, could create/remove the snapshots:

[client.privileged]
     key = AQA19uZUqIwkHxAAFuUwvq0eJD4S173oFRxe0g==
     caps mds = "allow rws /"
     caps mon = "allow *"
     caps osd = "allow *"

[client.global]
     key = xE21RuZTqIuiHxFFAuEwv4TjJD3R176BFOi4Fj==
     caps mds = "allow rw /"
     caps mon = "allow *"
     caps osd = "allow *"

Then specify the client ids when mounting:

$ sudo ./bin/mount.ceph privileged@.a=/ /mnt/privileged/mountpoint

$ sudo ./bin/mount.ceph global@.a=/ /mnt/global/mountpoint

Just to make sure only certain users, who have permission to 
create/remove snapshots, could access to the "/mnt/privileged/" directory.

I didn't read the openshift code, but when I was debugging the bugs and 
from the logs I saw it acting similarly to this.

> My patch decouples parent directory permissions from snapdir
> permissions, and it's a simple and elegant solution to my problem.

Yeah, I'm aware of the differences between these two approaches exactly. 
This should be a common feature not only in kernel client. We also need 
to implement this in cephfs user space client. If the above cephx 
permission approach could work very well everywhere, I am afraid this 
couldn't go to ceph in user space.

>> And then use the container or something else to make the specific users
>> could access to them.
> Sorry, I don't get it at all. What is "the container or something" and
> how does it enable me to prevent specific users from accessing
> snapdirs in their home directories?
>
Please see my above example. If that still won't work well, please send 
one mail in ceph-user to discuss this further, probably we can get more 
feedbacks from there.

Thanks!

- Xiubo

